import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const here = path.dirname(fileURLToPath(import.meta.url));
const repoRoot = path.resolve(here, '../..');
const resourcesDir = path.join(repoRoot, 'fsh-generated', 'resources');

// Read the generated Questionnaires straight off disk on every request, so the
// preview always reflects the current SUSHI output — even if the server was
// started before `fsh-generated/resources` existed, or SUSHI rewrote the whole
// directory. (A compile-time `import.meta.glob` is baked in once and misses both
// of those cases, which left the dropdown empty.)
function questionnaireApi() {
  const listFiles = () => {
    if (!fs.existsSync(resourcesDir)) return [];
    return fs
      .readdirSync(resourcesDir)
      .filter((f) => f.startsWith('Questionnaire-') && f.endsWith('.json'))
      .sort();
  };

  return {
    name: 'questionnaire-api',
    configureServer(server) {
      server.middlewares.use('/api/questionnaires', (req, res) => {
        const items = [];
        for (const file of listFiles()) {
          try {
            const json = JSON.parse(fs.readFileSync(path.join(resourcesDir, file), 'utf8'));
            items.push({ name: file.replace(/\.json$/, ''), questionnaire: json });
          } catch (err) {
            items.push({ name: file.replace(/\.json$/, ''), error: String(err) });
          }
        }
        res.setHeader('Content-Type', 'application/json');
        res.setHeader('Cache-Control', 'no-store');
        res.end(JSON.stringify(items));
      });

      // Full-reload the page whenever SUSHI regenerates a Questionnaire, so the
      // dropdown re-fetches the current list.
      const watcher = fs.existsSync(resourcesDir)
        ? server.watcher.add(resourcesDir)
        : server.watcher.add(path.join(repoRoot, 'fsh-generated'));
      const isQuestionnaire = (file) =>
        file.startsWith(resourcesDir) && path.basename(file).startsWith('Questionnaire-');
      for (const event of ['add', 'change', 'unlink']) {
        server.watcher.on(event, (file) => {
          if (isQuestionnaire(file)) server.ws.send({ type: 'full-reload' });
        });
      }
      void watcher;
    }
  };
}

export default defineConfig({
  root: here,
  plugins: [react(), questionnaireApi()],
  server: {
    port: 5173,
    open: true,
    // allow serving the generated JSON that lives outside tools/preview
    fs: { allow: [repoRoot] }
  }
});
