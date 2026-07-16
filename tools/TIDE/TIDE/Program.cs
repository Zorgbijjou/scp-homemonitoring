using System.CommandLine;

namespace TIDE;

public static class Program
{
    public static int Main(string[] args)
    {
        var fileArgument = new Argument<FileInfo>("input-file")
        {
            Description = "Path to the template file to render."
        }.AcceptExistingOnly();

        var outputOption = new Option<FileInfo?>("--output", "-o")
        {
            Description = "Write rendered output to <file> instead of stdout."
        };

        var rootCommand = new RootCommand(
            "Render a TIDE template: substitutes $variables and $gen_uuid tokens.")
        {
            fileArgument,
            outputOption
        };

        rootCommand.SetAction(parseResult =>
        {
            var file = parseResult.GetRequiredValue(fileArgument);
            var outputFile = parseResult.GetValue(outputOption);

            string input;
            try
            {
                input = File.ReadAllText(file.FullName);
            }
            catch (Exception ex) when (ex is IOException or UnauthorizedAccessException)
            {
                Console.Error.WriteLine($"tide: cannot read '{file.FullName}': {ex.Message}");
                return 1;
            }

            var result = TemplateEngine.Render(input);
            if (!result.IsOk())
            {
                foreach (var error in result.Errors())
                    Console.Error.WriteLine(error);
                return 1;
            }

            var output = result.Result!;
            if (outputFile is null)
            {
                Console.WriteLine(output);
                return 0;
            }

            try
            {
                File.WriteAllText(outputFile.FullName, output);
            }
            catch (Exception ex) when (ex is IOException or UnauthorizedAccessException)
            {
                Console.Error.WriteLine($"tide: cannot write '{outputFile.FullName}': {ex.Message}");
                return 1;
            }

            return 0;
        });

        return rootCommand.Parse(args).Invoke();
    }
}