# Questionnaire preview

A tiny Vite + React app for viewing the generated FHIR Questionnaires in the
browser, using the same [`@aehrc/smart-forms-renderer`](https://www.npmjs.com/package/@aehrc/smart-forms-renderer)
that renders them in production. It's a local dev aid — not part of the IG build.

## Running it

From `tools/` (where this tooling's `package.json` and `node_modules` live):

```bash
cd tools
npm install       # first time only
npm run dev       # SUSHI + preview, with a live edit loop (recommended)
npm run preview   # just the preview server (assumes fsh-generated is up to date)
```

`npm run dev` (see `tools/dev.mjs`) compiles FSH with SUSHI on startup and on
every `*.fsh` change, and serves this app with Vite. Edit a `.fsh` file → SUSHI
regenerates the JSON → the browser reloads with the new questionnaire.

`npm run preview` only starts Vite. Use it when the `fsh-generated/resources`
JSON is already current and you just want to look at it. Run `npm run sushi`
first if it isn't.

The app opens at http://localhost:5173. Pick a questionnaire from the dropdown;
it defaults to the atrial-fibrilation one.

## How it works

- `vite.config.mjs` — Vite config plus a small dev-only plugin
  (`questionnaire-api`) that:
  - serves `GET /api/questionnaires`, reading `fsh-generated/resources` **fresh
    from disk on every request** and returning each `Questionnaire-*.json` as
    `{ name, questionnaire }` (or `{ name, error }` if it can't be parsed);
  - watches that directory and pushes a `full-reload` to the browser whenever a
    `Questionnaire-*.json` is added, changed, or removed.
- `main.jsx` — fetches `/api/questionnaires` on mount, renders the dropdown, and
  passes the selected questionnaire to `SmartFormsRenderer`. The renderer is
  wrapped in an error boundary so one unrenderable questionnaire shows an inline
  error instead of blanking the whole page.
- `index.html` — the mount point.

### Why the runtime fetch (and not `import.meta.glob`)

An earlier version discovered questionnaires with
`import.meta.glob('.../Questionnaire-*.json', { eager: true })`. Vite resolves
that glob **once**, when it first transforms `main.jsx`, and only re-runs it for
changes inside a directory it was already watching. If the server was started
before `fsh-generated/resources` existed — or SUSHI rewrote the whole directory
— the glob compiled to zero matches and never recovered, leaving the dropdown
permanently empty. Reading the directory at request time sidesteps all of that:
the list always reflects what's on disk right now.

## Notes for changes

- This tool reads generated output only; it never writes to `fsh-generated`.
- Keep the discovery logic reading from disk at request time — don't reintroduce
  a compile-time glob (see above).
- `server.fs.allow` includes the repo root so Vite can serve JSON that lives
  outside `tools/preview`.
