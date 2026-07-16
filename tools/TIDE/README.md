# TIDE — Templating with Inline Data Expressions

We use [FSH](https://build.fhir.org/ig/HL7/fhir-shorthand/) to create questionnaires. FSH supports a
whole lot, but it is a cumbersome templating engine when it comes to forms. TIDE is a small C# utility
that adds some templating capabilities *on top of* FSH, without interfering with FSH's own syntax.

It reads a template file, expands TIDE expressions (variable bindings and UUID generation), and writes
the result to stdout or a file. Lines that TIDE consumes (like `var` bindings) are commented out rather
than deleted, so the output stays valid FSH and you can see what happened.

## Status

- [x] Template expansions — built-in templates
- [x] Variables / bindings — since we use UUIDs for `linkId`, it is handy to store a UUID in a variable
  and refer to it in multiple places.
- [x] UUID generation
- [ ] `enableWhen` with a single statement, instead of 3 lines of noise
- [ ] Grouping — enable or disable multiple questions through one `enableWhen`
- [ ] Shared header for each questionnaire

## Building

Requires the .NET 10 SDK.

```sh
dotnet build -c Release
```

## Usage

```
tide <input-file> [options]

Render a TIDE template: substitutes $variables and $gen_uuid tokens.

Arguments:
  <input-file>           Path to the template file to render (must exist).

Options:
  -o, --output <file>    Write rendered output to <file> instead of stdout.
  -h, --help             Show help and usage information.
  --version              Show version information.
```

### Examples

Render a template to stdout:

```sh
tide examples/VarSub.fsh
```

Render to a file:

```sh
tide examples/VarSub.fsh -o build/VarSub.fsh
```

During development you can run it without building a binary:

```sh
dotnet run --project TIDE -- examples/VarSub.fsh
```

### Exit codes

| Code | Meaning                                                                     |
|------|-----------------------------------------------------------------------------|
| `0`  | Rendered successfully                                                       |
| `1`  | Could not read/write a file, or the template had errors (printed to stderr) |
| `2`  | Invalid usage (missing argument, unknown option, input file does not exist) |

Render errors and I/O errors are written to **stderr**, the rendered output to **stdout**, so you can
safely pipe or redirect the result.

## Bindings

Syntax: `var <name> = <value>`

Binds `<name>` to `<value>`, comments out the defining line, and replaces every `$<name>` token with
`<value>`. The value is everything after the `=`, so it may contain spaces; include quotes if you want
them in the output. Rebinding an existing name is an error. `<name>` needs to be a single WORD, hypens (`-`) or dots (
`.`) will not work.

**INPUT:**

```fsh
var paceMakerId = "315d03f9-afdf-4cbe-a3cc-e970d756fb22"
* item[+]
  linkId = $paceMakerId
  text = "Heeft de patiënt een pacemaker?"
  type = #boolean
```

**OUTPUT:**

```fsh
// var paceMakerId = "315d03f9-afdf-4cbe-a3cc-e970d756fb22"
* item[+]
  linkId = "315d03f9-afdf-4cbe-a3cc-e970d756fb22"
  text = "Heeft de patiënt een pacemaker?"
  type = #boolean
```

A few details worth knowing:

- **Order does not matter.** A variable may be used before it is defined; all bindings are collected
  before substitution happens.
- **Only `$`-prefixed whole tokens are replaced.** A binding named `foo` does not touch `$foobar`, and
  the word `variable` is not mistaken for a `var` declaration.

**INPUT:**

```fsh
var foo = 42
var foobar = 24
variable stuff and other keywords with foo and foobar
lol = $foo
not_lol = $foobar
```

**OUTPUT:**

```fsh
// var foo = 42
// var foobar = 24
variable stuff and other keywords with foo and foobar
lol = 42
not_lol = 24
```

## UUID generation

`$gen_uuid` is replaced with a freshly generated UUID. Bind it to a variable when you need the same
UUID in more than one place — each standalone `$gen_uuid` produces a *different* UUID.

**INPUT:**

```fsh
var paceMakerId = $gen_uuid
* item[+]
  linkId = $paceMakerId
  text = "Heeft de patiënt een pacemaker?"
  type = #boolean
```

**OUTPUT:** (the UUID is random; both occurrences match because it is bound to a variable)

```fsh
// var paceMakerId = 7f3e9c1a-2b4d-4e6f-8a01-d2c3b4a5e6f7
* item[+]
  linkId = 7f3e9c1a-2b4d-4e6f-8a01-d2c3b4a5e6f7
  text = "Heeft de patiënt een pacemaker?"
  type = #boolean
```

## Template expansions

### Question Header template

Questions almost always start the same — a `linkId`, a `type` and a `text` are needed. A template call
expands into those lines in one go. One template, `question`, is built in:

**INPUT:**

```fsh
* item[+]
  $question("Why did the chicken cross the road?", "choice", $gen_uuid)
```

**OUTPUT:** 
```fsh
* item[+]
  linkId = 3922c0bd-4ac9-4370-a331-f875b647c204
  type = #choice
  text = "Why did the chicken cross the road?"
```

How it works:

- A call must be a line on its own: optional indentation, then `$name(...)`. The call's indentation is
  applied to every expanded line.
- **Arguments are quoted strings**, comma-separated. A comma inside the quotes is kept (`"a, b"` is one
  argument), and the count must match the template's parameters or rendering fails with an error.
- The template body controls FSH formatting: `question` emits a generated `linkId`, wraps the first
  argument in quotes for `text`, and prefixes the second with `#` for `type`.

Custom, in-file template definitions are planned; for now the set of templates is built in.


### EnableWhen template

The `enableWhen.*` always needs three lines, to make this more compact the `$enableWhen` template was added.

**INPUT:**

```fsh
* item[+]
  $question("Why did the chicken cross the road?", "choice")
```

**OUTPUT:** (`linkId` is a freshly generated UUID)

```fsh
* item[+]
  linkId = 3922c0bd-4ac9-4370-a331-f875b647c204
  type = #choice
  text = "Why did the chicken cross the road?"
```

How it works:

- A call must be a line on its own: optional indentation, then `$name(...)`. The call's indentation is
  applied to every expanded line.
- **Arguments are quoted strings**, comma-separated. A comma inside the quotes is kept (`"a, b"` is one
  argument), and the count must match the template's parameters or rendering fails with an error.
- The template body controls FSH formatting: `question` emits a generated `linkId`, wraps the first
  argument in quotes for `text`, and prefixes the second with `#` for `type`.

Custom, in-file template definitions are planned; for now the set of templates is built in.
