import React, { useEffect, useState } from 'react';
import { createRoot } from 'react-dom/client';
import { SmartFormsRenderer } from '@aehrc/smart-forms-renderer';

// The list of Questionnaires is fetched at runtime from the dev server, which
// reads `fsh-generated/resources` fresh on every request (see vite.config.mjs).
// The server also triggers a full page reload when SUSHI regenerates a file, so
// this fetch re-runs and the dropdown stays in sync with the current output.

// A render error in SmartFormsRenderer must not blank the whole page (and with
// it the dropdown) — trap it so the user can still switch questionnaires.
class RendererBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = { error: null };
  }
  static getDerivedStateFromError(error) {
    return { error };
  }
  componentDidUpdate(prev) {
    if (prev.resetKey !== this.props.resetKey && this.state.error) {
      this.setState({ error: null });
    }
  }
  render() {
    if (this.state.error) {
      return (
        <pre style={{ color: '#b00', whiteSpace: 'pre-wrap' }}>
          Failed to render this questionnaire:{'\n'}
          {String(this.state.error?.stack || this.state.error)}
        </pre>
      );
    }
    return this.props.children;
  }
}

function App() {
  const [items, setItems] = useState(null);
  const [name, setName] = useState(null);

  useEffect(() => {
    fetch('/api/questionnaires')
      .then((r) => r.json())
      .then((list) => {
        setItems(list);
        setName((cur) => {
          if (cur && list.some((i) => i.name === cur)) return cur;
          const af = list.find((i) => i.name.includes('atrial-fibrilation'));
          return af?.name ?? list[0]?.name ?? null;
        });
      })
      .catch((err) => setItems({ error: String(err) }));
  }, []);

  if (items && items.error) {
    return <p style={{ padding: 24 }}>Failed to load questionnaires: {items.error}</p>;
  }
  if (!items) {
    return <p style={{ padding: 24 }}>Loading…</p>;
  }
  if (items.length === 0) {
    return <p style={{ padding: 24 }}>No questionnaires found in fsh-generated/resources. Run SUSHI first.</p>;
  }

  const selected = items.find((i) => i.name === name);

  return (
    <div style={{ maxWidth: 760, margin: '0 auto', padding: 24, fontFamily: 'sans-serif' }}>
      <label style={{ display: 'block', marginBottom: 16, fontSize: 14 }}>
        Questionnaire:{' '}
        <select value={name ?? ''} onChange={(e) => setName(e.target.value)}>
          {items.map((i) => (
            <option key={i.name} value={i.name}>
              {i.name}
            </option>
          ))}
        </select>
      </label>
      {selected?.error ? (
        <p style={{ color: '#b00' }}>Could not parse this questionnaire: {selected.error}</p>
      ) : selected ? (
        // key forces a clean re-init of the renderer's global store on switch
        <RendererBoundary resetKey={name}>
          <SmartFormsRenderer key={name} questionnaire={selected.questionnaire} />
        </RendererBoundary>
      ) : null}
    </div>
  );
}

createRoot(document.getElementById('root')).render(<App />);
