namespace TIDE.Tests;

public class TemplateEngineTests
{
    [Theory]
    [InlineData("key", "\"315d03f9-afdf-4cbe-a3cc-e970d756fb22\"")]
    [InlineData("key", "315d03f9-afdf-4cbe-a3cc-e970d756fb22")]
    public void Bindings(string name, string value)
    {
        var input =
            $"""
             var {name} = {value}
             * item[+]
               linkId = ${name}
               text = "Heeft de patiënt een pacemaker?"
               type = #boolean
             """;

        var result = TemplateEngine.Render(input);

        var expected =
            $"""
             // var {name} = {value}
             * item[+]
               linkId = {value}
               text = "Heeft de patiënt een pacemaker?"
               type = #boolean
             """;

        Assert.True(result.IsOk());
        Assert.Equal(expected, result.Result);
    }


    [Fact]
    public void BindingReplacement()
    {
        var input =
            """
            var foo = 42
            var foobar = 24
            variable stuff and other keywords with foo and foobar
            var $Flecainide = "Flecainide kortwerkend - 1 tablet"
            var $Flecainide2x = "Flecainide kortwerkend - 2 tabletten"
            answerOption[+].valueString = "Flecainide kortwerkend - 1 tablet"
            answerOption[+].valueString = "Flecainide kortwerkend - 2 tabletten"
            lol = $foo
            not_lol = $foobar
            """;

        var result = TemplateEngine.Render(input);

        var expected =
            """
            // var foo = 42
            // var foobar = 24
            variable stuff and other keywords with foo and foobar
            // var $Flecainide = "Flecainide kortwerkend - 1 tablet"
            // var $Flecainide2x = "Flecainide kortwerkend - 2 tabletten"
            answerOption[+].valueString = "Flecainide kortwerkend - 1 tablet"
            answerOption[+].valueString = "Flecainide kortwerkend - 2 tabletten"
            lol = 42
            not_lol = 24
            """;

        Assert.True(result.IsOk());
        Assert.Equal(expected, result.Result);
    }

    [Fact]
    public void Bindings2()
    {
        var input =
            """
            * item[+]
              linkId = $paceMakerId
              text = "Heeft de patiënt een pacemaker?"
              type = #boolean
            var paceMakerId = "315d03f9-afdf-4cbe-a3cc-e970d756fb22"
            """;

        var result = TemplateEngine.Render(input);

        var expected =
            """
            * item[+]
              linkId = "315d03f9-afdf-4cbe-a3cc-e970d756fb22"
              text = "Heeft de patiënt een pacemaker?"
              type = #boolean
            // var paceMakerId = "315d03f9-afdf-4cbe-a3cc-e970d756fb22"
            """;

        Assert.True(result.IsOk());
        Assert.Equal(expected, result.Result);
    }

    [Fact]
    public void Bindings_RebindingIsNotAllowed()
    {
        var input =
            """
            var paceMakerId = "315d03f9-afdf-4cbe-a3cc-e970d756fb22"
            * item[+]
              linkId = $paceMakerId
              text = "Heeft de patiënt een pacemaker?"
              type = #boolean
            var paceMakerId = "NOT ALLOWED"
            """;

        var result = TemplateEngine.Render(input);
        Assert.False(result.IsOk());
    }

    [Fact]
    public void Bindings_WithUuidGen()
    {
        var input =
            """
            var paceMakerId = $gen_uuid
            * item[+]
              linkId = $paceMakerId
              text = "Heeft de patiënt een pacemaker?"
              type = #boolean
            """;

        var result = TemplateEngine.Render(input);

        Assert.True(result.IsOk());
    }

    [Fact]
    public void VariableSub_WhenNameIsPrefixOfAnother_DoesNotCorruptLongerName()
    {
        // $foo is a prefix of $foobar. Substring-based replacement of $foo
        // would also rewrite the $foo inside $foobar.
        var input =
            """
            var foo = AAA
            var foobar = BBB
            * item = $foo $foobar
            """;

        var result = TemplateEngine.Render(input);

        var expected =
            """
            // var foo = AAA
            // var foobar = BBB
            * item = AAA BBB
            """;

        Assert.True(result.IsOk());
        Assert.Equal(expected, result.Result);
    }

    [Fact]
    public void VariableSub_WhenNameIsPrefixOfAnother_OrderOfUseDoesNotMatter()
    {
        // Same collision, but the longer name is used first on the line.
        var input =
            """
            var foo = AAA
            var foobar = BBB
            * item = $foobar $foo
            * item = "<style>div[data-linkid="$foobar"]"
            """;

        var result = TemplateEngine.Render(input);

        var expected =
            """
            // var foo = AAA
            // var foobar = BBB
            * item = BBB AAA
            * item = "<style>div[data-linkid="BBB"]"
            """;

        Assert.True(result.IsOk());
        Assert.Equal(expected, result.Result);
    }

    [Fact]
    public void VariableSub_LongerNameAlone_IsNotMatchedByShorterPrefix()
    {
        // Only $foobar appears on the line; the existence of the $foo binding
        // must not cause $foobar to be partially substituted.
        var input =
            """
            var foo = AAA
            var foobar = BBB
            * item = $foobar
            """;

        var result = TemplateEngine.Render(input);

        var expected =
            """
            // var foo = AAA
            // var foobar = BBB
            * item = BBB
            """;

        Assert.True(result.IsOk());
        Assert.Equal(expected, result.Result);
    }

    [Fact]
    public void Template_Question_GeneratesUuidForLinkId()
    {
        var input =
            """
            * item[+]
              $question("Why did the chicken cross the road?", choice, $gen_uuid)
            """;

        var result = TemplateEngine.Render(input);

        Assert.True(result.IsOk());
        var lines = result.Result!.Split(Environment.NewLine);
        // linkId should be a freshly generated UUID.
        Assert.Matches(
            """^  \* linkId = "[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}"$""",
            lines[1]);
    }

    [Fact]
    public void Template_Question_SubstitutesQuotedTextArgument()
    {
        var input =
            """
            * item[+]
              $question("Why did the chicken cross the road?", choice, $gen_uuid)
            """;

        var result = TemplateEngine.Render(input);

        Assert.True(result.IsOk());
        Assert.Contains("* text = \"Why did the chicken cross the road?\"", result.Result);
    }

    [Fact]
    public void RadioButtonChoiceTemplate()
    {
        var input =
            """
            * item[+]
              Text = "test"
              $radioButtonChoice()
            """;

        var result = TemplateEngine.Render(input);
        Assert.True(result.IsOk());
        Assert.Contains("  * valueCodeableConcept = $questionnaire-item-control#radio-button", result.Result);
        Assert.DoesNotContain("$radioButtonChoice", result.Result);
    }

    [Fact]
    public void OpenChoiceTemplate()
    {
        var input =
            """
            * item[+]
              Text = "test"
              $openChoice("This is a, test")
            """;

        var result = TemplateEngine.Render(input);
        Assert.True(result.IsOk());
        Assert.Contains("  * valueString = \"This is a, test\"", result.Result);
        Assert.DoesNotContain("$openChoice", result.Result);
    }

    [Fact]
    public void OpenChoicePlaceholderTemplate()
    {
        var input =
            """
            * item[+]
              * linkId = "q1"
              * type = #choice
              $openChoicePlaceholder("driver", "Verapamil", "Verapamil2x", "Anders, namelijk")
            """;

        var result = TemplateEngine.Render(input);
        Assert.True(result.IsOk());
        Assert.DoesNotContain("$openChoicePlaceholder", result.Result);
        // The placeholder no longer adds a radio option.
        Assert.DoesNotContain("* answerOption", result.Result);
        Assert.Contains("* type = #string", result.Result);
        Assert.Contains("* enableBehavior = #any", result.Result);
        // Gated on the driving question's values, not on the choice item's own answer.
        Assert.Contains("* enableWhen[+].question = \"driver\"", result.Result);
        Assert.Contains("* enableWhen[=].answerString = \"Verapamil\"", result.Result);
        Assert.Contains("* enableWhen[=].answerString = \"Verapamil2x\"", result.Result);
        Assert.Contains(
            "* extension[+].url = \"http://hl7.org/fhir/StructureDefinition/entryFormat\"",
            result.Result);
        Assert.Contains("* extension[=].valueString = \"Anders, namelijk\"", result.Result);
    }

    [Fact]
    public void Template_Question_SubstitutesTypeArgument()
    {
        var input =
            """
            * item[+]
              $question("Why did the chicken cross the road?", choice, $gen_uuid)
            """;

        var result = TemplateEngine.Render(input);

        Assert.True(result.IsOk());
        Assert.Contains("* type = #choice", result.Result);
    }

    [Fact]
    public void Template_InheritsCallSiteIndentation()
    {
        var input =
            """
            * item[+]
              $question("Why did the chicken cross the road?", choice, $gen_uuid)
            """;

        var result = TemplateEngine.Render(input);

        Assert.True(result.IsOk());
        var lines = result.Result!.Split(Environment.NewLine);
        // The call was indented two spaces; every emitted body line inherits it.
        Assert.Equal("* item[+]", lines[0]);
        Assert.All(lines[1..], line => Assert.StartsWith("  ", line));
    }

    [Fact]
    public void Template_ArgCountMismatch_IsError()
    {
        var input =
            """
            * item[+]
              $question("only one arg")
            """;

        var result = TemplateEngine.Render(input);

        Assert.False(result.IsOk());
    }

    [Fact]
    public void Template_UnknownName_PassesThrough()
    {
        var input =
            """
            * item[+]
              $widget("x")
            """;

        var result = TemplateEngine.Render(input);

        Assert.True(result.IsOk());
        Assert.Contains("$widget(\"x\")", result.Result);
    }

    [Fact]
    public void Template_QuotedArgWithComma_TypeIsProcessed()
    {
        var input =
            """
            * item[+]
              $question("ignored", choice, "")
            """;

        var result = TemplateEngine.Render(input);

        Assert.True(result.IsOk());
        // `type` takes a bare code, so it renders with a leading # and no quotes.
        Assert.Contains("* type = #choice", result.Result);
    }

    [Fact]
    public void Template_TwoCalls_ProduceDistinctLinkIds()
    {
        var input =
            """
            * item[+]
              $question("First?", "choice", 12)
            * item[+]
              $question("Second?", "choice", "abc")
            """;

        var result = TemplateEngine.Render(input);

        Assert.True(result.IsOk());
        var linkIds = result.Result!.Split(Environment.NewLine)
            .Where(l => l.TrimStart().StartsWith("* linkId = "))
            .ToArray();
        Assert.Equal(2, linkIds.Length);
        Assert.NotEqual(linkIds[0], linkIds[1]);
    }


    [Fact]
    public void Template_NonVisualGroup()
    {
        var input =
            """
            var pillInPocketGroup = MuId-14783hd
            $nonVisualGroup($pillInPocketGroup)
            """;

        var result = TemplateEngine.Render(input);

        Assert.True(result.IsOk());
        Assert.Equal(
            """
            // var pillInPocketGroup = MuId-14783hd
            * item[+]
              * linkId = "MuId-14783hd"
              * type = #group
              * text = " "
                * extension[+]
                  * url = "http://hl7.org/fhir/StructureDefinition/rendering-xhtml"
                  * valueString = "<style>div[data-linkid=\"MuId-14783hd\"] > div { padding: 0; padding-top: 32px; padding-bottom:32px; padding-left:40px; background-color: #EAF7F880; box-shadow: none; > :nth-child(-n + 2) { display: none; } }</style>"
            """,
            result.Result
        );
    }

    // --- Argument parser (exercised through the built-in `question` template) ---
    // question params are [__text, __type, __id]; body emits:
    //   * linkId = $__id   |   * type = #$__type   |   * text = $__text
    // so $question(A, B, C) => text=A, type=#B, linkId=C.

    [Fact]
    public void ArgParse_BareAndQuotedArgs_AreSubstituted()
    {
        var input =
            """
            * item[+]
              $question("Why?", choice, abc-123)
            """;

        var result = TemplateEngine.Render(input);

        Assert.True(result.IsOk());
        Assert.Contains("* text = \"Why?\"", result.Result); // quotes kept on string arg
        Assert.Contains("* type = #choice", result.Result); // bare identifier
        Assert.Contains("* linkId = abc-123", result.Result); // bare arg with a hyphen
    }

    [Fact]
    public void ArgParse_CommaInsideQuotes_StaysOneArgument()
    {
        var input =
            """
            * item[+]
              $question("a, b, c", choice, id1)
            """;

        var result = TemplateEngine.Render(input);

        Assert.True(result.IsOk());
        // The commas are inside the quotes, so the whole thing is the single `text` arg.
        Assert.Contains("* text = \"a, b, c\"", result.Result);
        Assert.Contains("* linkId = id1", result.Result);
    }

    [Fact]
    public void ArgParse_TrimsWhitespaceAroundArguments()
    {
        var input =
            """
            * item[+]
              $question(  "Why?" ,  choice ,  my-id  )
            """;

        var result = TemplateEngine.Render(input);

        Assert.True(result.IsOk());
        Assert.Contains("* text = \"Why?\"", result.Result);
        Assert.Contains("* type = #choice", result.Result);
        Assert.Contains("* linkId = my-id", result.Result);
    }

    [Fact]
    public void ArgParse_NumericArg_IsSubstituted()
    {
        var input =
            """
            * item[+]
              $question("Why?", code, 42)
            """;

        var result = TemplateEngine.Render(input);

        Assert.True(result.IsOk());
        Assert.Contains("* linkId = 42", result.Result);
    }

    [Fact]
    public void ArgParse_EmptyQuotedArg_IsSubstituted()
    {
        var input =
            """
            * item[+]
              $question("", code, my-id)
            """;

        var result = TemplateEngine.Render(input);

        Assert.True(result.IsOk());
        Assert.Contains("* text = \"\"", result.Result);
        Assert.Contains("* linkId = my-id", result.Result);
    }
}