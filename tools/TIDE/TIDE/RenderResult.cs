namespace TIDE;

public class RenderResult
{
    private List<string> _errors = [];
    public string? Result { get; }
    
    public bool IsOk() => Result != null;
    public IReadOnlyList<string> Errors() => _errors;

    private RenderResult(string? result)
    {
        Result = result;
    }

    public static RenderResult WithErrors(List<string> errors)
    {
        return new RenderResult(null)
        {
            _errors = errors
        };
    }

    public static RenderResult Ok(string result) => new RenderResult(result);
}