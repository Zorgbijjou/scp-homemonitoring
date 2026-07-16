using System.Text;
using System.Text.RegularExpressions;

namespace TIDE;

public class TemplateEngine
{
    private static readonly string[] Keywords =
    [
        "gen_uuid", "var"
    ];

    private static readonly char[] WordSplit = ['\t', ' '];
    private readonly Dictionary<string, Template> _templates = [];
    private readonly Dictionary<string, string> _bindings = [];
    private List<Pair> _workingSet = [];
    private readonly List<string> _errors = [];

    private static readonly Regex VarToken = new(@"(?<!\w)\$(\w+)", RegexOptions.Compiled);

    private static readonly Regex CallToken = new(@"^(\s*)\$(\w+)\((.*)\)\s*$", RegexOptions.Compiled);

    public TemplateEngine()
    {
        _templates["question"] =
            new Template(
                ["__text", "__type", "__id"],
                [
                    "* linkId = $__id",
                    "* type = #$__type",
                    "* text = $__text",
                ]);

        _templates["enableWhenString"] =
            new Template(
                ["__questionId", "__value"],
                [
                    "* enableWhen[+].question = $__questionId",
                    "* enableWhen[=].operator = #=",
                    "* enableWhen[=].answerString = $__value",
                ]);

        _templates["enableWhenBoolean"] =
            new Template(
                ["__questionId", "__value"],
                [
                    "* enableWhen[+].question = $__questionId",
                    "* enableWhen[=].operator = #=",
                    "* enableWhen[=].answerBoolean = $__value",
                ]);
        _templates["radioButtonChoice"] =
            new Template(
                [],
                [
                    "* extension[+]",
                    "  * url = \"http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl\"",
                    "  * valueCodeableConcept = $questionnaire-item-control#radio-button"
                ]);
        _templates["openChoice"] =
            new Template(
                ["__text"],
                [
                    "* extension[+]",
                    "  * url = \"http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-openLabel\"",
                    "  * valueString = $__text",
                ]);
        _templates["openChoiceDate"] =
            new Template(
                ["__text"],
                [
                    "* extension[+]",
                    "  * url = \"http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-openLabel\"",
                    "  * valueDate = $__text",
                ]);
        // Renders a free-text "other" input as a greyed-out placeholder (entryFormat)
        // with no visible label and no extra radio option. The Smart Forms renderer only
        // shows entryFormat placeholders on plain #string items, so this emits a label-less
        // #string sibling. Gate it on the SAME question/values that enable the choice item
        // itself (NOT on the choice item's own answer): a disabled item's answer is not
        // cleared, so keying off the choice's own answer would leave the box stranded when
        // the driving question changes. Pass the same value twice if there is only one.
        // Usage: $openChoicePlaceholder($PillInPocket, $Verapamil, $Verapamil2x, "Anders, namelijk")
        _templates["openChoicePlaceholder"] =
            new Template(
                ["__questionId", "__value1", "__value2", "__placeholder"],
                [
                    "* item[+]",
                    "  * linkId = $gen_uuid",
                    "  * type = #string",
                    "  * enableBehavior = #any",
                    "  * enableWhen[+].question = $__questionId",
                    "  * enableWhen[=].operator = #=",
                    "  * enableWhen[=].answerString = $__value1",
                    "  * enableWhen[+].question = $__questionId",
                    "  * enableWhen[=].operator = #=",
                    "  * enableWhen[=].answerString = $__value2",
                    "  * extension[+].url = \"http://hl7.org/fhir/StructureDefinition/entryFormat\"",
                    "  * extension[=].valueString = $__placeholder",
                ]);
        _templates["noIndentGroup"] =
            new Template(
                ["__id"],
                [
                    "* item[+]",
                    "  * linkId = \"$__id\"",
                    "  * type = #group",
                    "  * text = \" \"",
                    "    * extension[+]",
                    "      * url = \"http://hl7.org/fhir/StructureDefinition/rendering-xhtml\"",
                    "      * valueString = \"<style>div[data-linkid=\\\"$__id\\\"] > div { padding: 0; overflow: visible; background-color: #EAF7F880; box-shadow: none; > :nth-child(-n + 2) { display: none; } }</style>\"",
                ]);
        _templates["groupWithGreenBg"] =
            new Template(
                ["__id"],
                [
                    "* item[+]",
                    "  * linkId = \"$__id\"",
                    "  * type = #group",
                    "  * text = \" \"",
                    "    * extension[+]",
                    "      * url = \"http://hl7.org/fhir/StructureDefinition/rendering-xhtml\"",
                    "      * valueString = \"<style>div[data-linkid=\\\"$__id\\\"] > div { padding: 0; padding-top: 32px; padding-bottom:32px; padding-left:40px; background-color: #EAF7F880; box-shadow: none; > :nth-child(-n + 2) { display: none; } }</style>\"",
                ]);
        _templates["nonIndentingGroepGreenBg"] =
            new Template(
                ["__id"],
                [
                    "* item[+]",
                    "  * linkId = \"$__id\"",
                    "  * type = #group",
                    "  * text = \" \"",
                    "    * extension[+]",
                    "      * url = \"http://hl7.org/fhir/StructureDefinition/rendering-xhtml\"",
                    "      * valueString = \"<style>div[data-linkid=\\\"$__id\\\"] > div { padding: 0; overflow: visible; background-color: #EAF7F800; box-shadow: none; > :nth-child(-n + 1) { display: none; } }</style>\"",
                ]);
    }

    public static RenderResult Render(string input)
    {
        var te = new TemplateEngine();
        return te.RenderInternal(input);
    }

    private RenderResult RenderInternal(string input)
    {
        _workingSet = SplitIntoPairs(input);
        ExpandTemplates();

        SetUuids();
        ScanForBindings();
        ExpandVariables();

        // Reconstruct the input
        var lines = _workingSet.Select(p => p.Line);
        var sb = new StringBuilder();
        var output = sb
            .AppendJoin(Environment.NewLine, lines)
            .ToString();

        return _errors.Count > 0 ? RenderResult.WithErrors(_errors) : RenderResult.Ok(output);
    }

    private static List<Pair> SplitIntoPairs(string input) =>
        input
            .ReplaceLineEndings()
            .Split(Environment.NewLine)
            .Select((l, i) => new Pair(l, i))
            .ToList();

    private void ExpandTemplates()
    {
        _workingSet = _workingSet
            .SelectMany(pair =>
            {
                // Line is a candidate for template expansion
                var m = CallToken.Match(pair.Line);
                if (!m.Success || !_templates.TryGetValue(m.Groups[2].Value, out var t))
                    return [pair];

                var indent = m.Groups[1].Value;

                // Try to extract the arguments
                var args = ArgParse(m.Groups[3].Value);
                if (args.Count != t.Params.Length)
                {
                    _errors.Add(
                        $"Line {pair.Index:0000}: '{m.Groups[2].Value}' expects {t.Params.Length} args, got {args.Count}");
                    return [pair];
                }

                // Create a map from argument name to value
                var argMap = t.Params
                    .Zip(args)
                    .ToDictionary(x => x.First, x => x.Second);

                return t.Body.Select(line =>
                {
                    // In the body lines to a variable sub like in ExpandVariables, but with the argMap as source for the values
                    var replaced = VarToken.Replace(line,
                        match => argMap.TryGetValue(match.Groups[1].Value, out var value) ? value : match.Value
                    );
                    return pair with { Line = indent + replaced };
                });
            })
            .ToList();
    }

    private static List<string> ArgParse(string args)
    {
        var sb = new StringBuilder();
        var parsed = new List<string>();
        var inQuotes = false;

        foreach (var c in args)
        {
            switch (c)
            {
                case '"':
                    inQuotes = !inQuotes;
                    sb.Append(c);
                    break;
                case ',' when !inQuotes:
                    parsed.Add(sb.ToString().Trim());
                    sb.Clear();
                    break;
                default:
                    sb.Append(c);
                    break;
            }
        }

        // flush the final argument (skip a truly empty arg list, e.g. "$foo()")
        if (sb.Length > 0 || parsed.Count > 0)
            parsed.Add(sb.ToString().Trim());

        return parsed;
    }

    private void ScanForBindings()
    {
        _workingSet = _workingSet.Select(pair =>
                {
                    var lineParts = pair.Line.Split(WordSplit, StringSplitOptions.RemoveEmptyEntries);
                    if (lineParts is ["var", var key, "=", .. var valueParts] && valueParts.Length > 0)
                    {
                        if (Keywords.Contains(key))
                        {
                            _errors.Add($"Line {pair.Index:0000} cannot use keyword as var name: '{key}'");
                            return pair;
                        }

                        if (_bindings.ContainsKey(key))
                        {
                            _errors.Add($"Line {pair.Index:0000} cannot rebind name: '{key}'");
                            return pair;
                        }

                        _bindings[key] = string.Join(' ', valueParts);
                        return pair with { Line = $"// {pair.Line}" };
                    }

                    return pair;
                }
            )
            .ToList();
    }

    private void ExpandVariables()
    {
        _workingSet = _workingSet
            .Select(pair =>
            {
                var line = pair.Line;
                if (line.StartsWith("//"))
                    return pair;

                var subbed = VarToken.Replace(pair.Line, m =>
                    _bindings.TryGetValue(m.Groups[1].Value, out var value) ? value : m.Value);

                return pair with { Line = subbed };
            })
            .ToList();
    }

    private void SetUuids()
    {
        _workingSet = _workingSet.Select(pair =>
            {
                var line = pair.Line;
                if (line.StartsWith("//"))
                    return pair;

                var subbedString = line
                    .Split(WordSplit, StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries)
                    .Where(s => s is "$gen_uuid" or "$gen_uuid_bare")
                    .Aggregate(line, (current, match) => current
                        .Replace(match,
                            match == "$gen_uuid"
                                ? $"\"{Guid.NewGuid().ToString()}\""
                                : $"{Guid.NewGuid().ToString()}"));

                return pair with { Line = subbedString };
            })
            .ToList();
    }

    private readonly record struct Pair(string Line, int Index);

    private readonly record struct Template(string[] Params, string[] Body);
}