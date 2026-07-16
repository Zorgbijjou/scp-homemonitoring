// One command to preview questionnaires locally with a tight edit loop:
//   - compiles FSH with SUSHI on startup and on every *.fsh change
//   - serves tools/preview with Vite; the browser hot-reloads when the
//     generated JSON changes
//
// Usage: npm run dev   (from tools/)

import { spawn } from 'node:child_process';
import { watch } from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const toolsDir = path.dirname(fileURLToPath(import.meta.url));
const repoRoot = path.resolve(toolsDir, '..');
const fshDir = path.join(repoRoot, 'input', 'fsh');
const npx = process.platform === 'win32' ? 'npx.cmd' : 'npx';

// Run from toolsDir so npx resolves binaries from tools/node_modules, where the
// tooling's dependencies live. sushi/vite are pointed at the repo root
// explicitly (below), so their output still lands outside tools/.
function run(cmd, args, opts = {}) {
  return spawn(cmd, args, { stdio: 'inherit', cwd: toolsDir, ...opts });
}

// --- SUSHI build (debounced, non-overlapping) ---
let building = false;
let queued = false;

function build() {
  if (building) {
    queued = true;
    return;
  }
  building = true;
  console.log('\n[sushi] compiling…');
  const proc = run(npx, ['sushi', repoRoot]);
  proc.on('exit', (code) => {
    building = false;
    console.log(`[sushi] done (exit ${code})`);
    if (queued) {
      queued = false;
      build();
    }
  });
}

build();

let debounce;
watch(fshDir, { recursive: true }, (_event, file) => {
  if (file && !file.endsWith('.fsh')) return;
  clearTimeout(debounce);
  debounce = setTimeout(build, 200);
});
console.log(`[watch] ${fshDir} → recompile on *.fsh change`);

// --- Vite dev server ---
const vite = run(npx, ['vite', '--config', 'preview/vite.config.mjs']);

function shutdown() {
  vite.kill();
  process.exit(0);
}
process.on('SIGINT', shutdown);
process.on('SIGTERM', shutdown);
