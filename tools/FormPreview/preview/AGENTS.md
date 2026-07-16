# AGENTS.md — Questionnaire preview tool

Scope: `tools/preview/` (a local Vite + React viewer for the generated FHIR
Questionnaires). Read `README.md` here first for the full picture; this file is
the short version of what matters when editing.

## What this is

A dev-only aid to view `fsh-generated/resources/Questionnaire-*.json` in the
browser via `@aehrc/smart-forms-renderer` — the same renderer used in
production. It is **not** part of the IG / SUSHI build output.

## Files

- `vite.config.mjs` — Vite config + the `questionnaire-api` dev plugin
  (serves `/api/questionnaires`, watches the resources dir for reloads).
- `main.jsx` — React app: fetches the list, dropdown, error-bounded renderer.
- `index.html` — mount point.

## How to run and verify

- `npm run dev` (from `tools/`) — SUSHI + preview with a live edit loop.
- `npm run preview` (from `tools/`) — just Vite; assumes `fsh-generated` is current.
- Opens at http://localhost:5173.

The tooling's `package.json`, lockfile, and `node_modules` live in `tools/`
(the whole dir is gitignored), so run npm from there, not the repo root.

To verify a change without a GUI browser, hit the API and/or dump the DOM
headlessly:

```bash
npm run preview -- --port 5199 --no-open   # background it
curl -s http://localhost:5199/api/questionnaires   # expect a JSON array, one entry per Questionnaire-*.json
chromium --headless=new --disable-gpu --no-sandbox --virtual-time-budget=9000 --dump-dom http://localhost:5199/ | grep -c '<option'
```

The `<option>` count should equal the number of `Questionnaire-*.json` files.

## Rules / gotchas — don't regress these

- **Discover questionnaires by reading the directory at request time**, not with
  `import.meta.glob`. The compile-time glob is baked in once and goes stale if
  the server started before `fsh-generated/resources` existed or SUSHI rewrote
  the directory — that's the bug that left the dropdown empty. Keep discovery in
  the dev-server middleware.
- **Read-only:** this tool must never write to `fsh-generated` or `input/`.
- **Keep the renderer error-bounded.** A single unrenderable questionnaire must
  not blank the whole page (and the dropdown with it).
- `server.fs.allow` must include the repo root so Vite can serve JSON outside
  `tools/preview`.
- Keep this a small, dependency-light dev tool. Don't pull in a router, state
  library, or build step beyond Vite.

## After changing anything here

Restart the preview server and confirm the dropdown lists every
`Questionnaire-*.json` and the selected one renders (see verify steps above).
