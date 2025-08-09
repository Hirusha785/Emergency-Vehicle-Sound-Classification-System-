<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Emergency Vehicle Sound Classification System</title>
  <style>
    :root {
      --bg: #0b1017;
      --panel: #121826;
      --muted: #94a3b8;
      --text: #e5e7eb;
      --accent: #60a5fa;
      --accent-2: #34d399;
      --border: #1f2937;
      --chip: #111827;
    }
    * { box-sizing: border-box; }
    html, body { height: 100%; }
    body {
      margin: 0;
      font-family: system-ui, -apple-system, Segoe UI, Roboto, Ubuntu, Cantarell, Noto Sans, Arial, "Apple Color Emoji", "Segoe UI Emoji";
      background: linear-gradient(180deg, #0b1017 0%, #0b1320 60%, #0b1017 100%);
      color: var(--text);
      line-height: 1.6;
    }
    .container {
      max-width: 1100px;
      margin: 0 auto;
      padding: 32px 20px 56px;
    }
    header {
      display: grid;
      gap: 10px;
      margin-bottom: 28px;
    }
    .title {
      display: flex;
      align-items: center;
      gap: 12px;
      font-size: clamp(24px, 3.5vw, 40px);
      font-weight: 800;
      letter-spacing: 0.2px;
    }
    .subtitle { color: var(--muted); font-size: 16px; }

    .grid { display: grid; gap: 16px; }
    @media (min-width: 768px) {
      .grid-2 { grid-template-columns: repeat(2, minmax(0, 1fr)); }
      .grid-3 { grid-template-columns: repeat(3, minmax(0, 1fr)); }
      .grid-4 { grid-template-columns: repeat(4, minmax(0, 1fr)); }
    }

    .card {
      background: radial-gradient(80% 120% at 0% 0%, rgba(96,165,250,0.12), transparent 60%),
                  radial-gradient(90% 130% at 100% 0%, rgba(52,211,153,0.10), transparent 60%),
                  var(--panel);
      border: 1px solid var(--border);
      border-radius: 18px;
      padding: 18px 18px 16px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.25);
    }
    .card h3 {
      margin: 0 0 10px;
      font-size: 18px;
      font-weight: 700;
      letter-spacing: 0.2px;
    }
    .section h2 {
      margin: 22px 0 10px;
      font-size: 20px;
      font-weight: 800;
      letter-spacing: 0.3px;
    }

    .stat {
      display: grid;
      gap: 2px;
      padding: 14px;
      border-radius: 14px;
      background: linear-gradient(180deg, rgba(255,255,255,0.02), rgba(255,255,255,0.00));
      border: 1px solid var(--border);
    }
    .stat .label { color: var(--muted); font-size: 12px; }
    .stat .value { font-weight: 800; font-size: 20px; }

    .table {
      overflow: hidden;
      border-radius: 14px;
      border: 1px solid var(--border);
    }
    table { width: 100%; border-collapse: collapse; background: rgba(17,24,39,0.35); }
    th, td { padding: 12px 14px; text-align: left; }
    th { font-size: 13px; color: var(--muted); background: rgba(255,255,255,0.02); }
    tr + tr td { border-top: 1px dashed var(--border); }

    code, pre, kbd {
      font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
    }
    code, kbd { background: #0f172a; border: 1px solid var(--border); padding: 0.15rem 0.4rem; border-radius: 8px; }
    pre { background: #0b1220; border: 1px solid var(--border); padding: 14px; border-radius: 14px; overflow:auto; }

    .chip {
      display: inline-flex; align-items: center; gap: 8px;
      padding: 6px 10px; border-radius: 999px;
      border: 1px solid var(--border); background: var(--chip);
      font-size: 12px; color: var(--muted);
    }
    .chips { display: flex; flex-wrap: wrap; gap: 8px; }

    .badge { color: white; background: linear-gradient(90deg, var(--accent), var(--accent-2)); padding: 6px 10px; border-radius: 999px; font-weight: 700; font-size: 12px; }

    .footer { color: var(--muted); font-size: 13px; margin-top: 18px; }
    .divider { height: 1px; background: linear-gradient(90deg, transparent, var(--border), transparent); margin: 28px 0; }
  </style>
</head>
<body>
  <div class="container">
    <header>
      <div class="title">Emergency Vehicle Sound Classification System <span aria-hidden="true">🚨</span></div>
      <p class="subtitle">A MATLAB-based machine learning system for classifying ambulance <span aria-hidden="true">🚑</span> and firetruck <span aria-hidden="true">🚒</span> siren sounds using digital signal processing and SVMs.</p>
      <div class="chips" role="list" aria-label="highlights">
        <span class="chip">Made with MATLAB R2021a+</span>
        <span class="chip">Signal Processing Toolbox</span>
        <span class="chip">Statistics &amp; ML Toolbox</span>
      </div>
    </header>

    <section class="section">
      <h2>Technical Overview <span aria-hidden="true">📊</span></h2>
      <div class="grid grid-3">
        <div class="stat" aria-label="classification accuracy">
          <div class="label">Classification Accuracy</div>
          <div class="value">86.15% <small style="color:var(--muted); font-weight:600">(Test)</small> · 94.61% <small style="color:var(--muted); font-weight:600">(Cross‑Val)</small></div>
        </div>
        <div class="stat" aria-label="processing time">
          <div class="label">Processing Time</div>
          <div class="value">&lt; 5 ms/sample <span aria-hidden="true">⚡</span></div>
        </div>
        <div class="stat" aria-label="optimal threshold">
          <div class="label">Optimal Threshold</div>
          <div class="value">τ = 0.244 <small style="color:var(--muted); font-weight:600">(MAD‑optimized)</small> <span aria-hidden="true">📈</span></div>
        </div>
      </div>

      <div class="divider"></div>

      <div class="grid grid-2">
        <div class="card">
          <h3>Frequency Bands — Ambulance <span aria-hidden="true">🚑</span></h3>
          <div class="table" role="region" aria-label="ambulance frequency bands">
            <table>
              <thead>
                <tr><th>Band</th><th>Range (Hz)</th></tr>
              </thead>
              <tbody>
                <tr><td>Band 1</td><td>300 – 800</td></tr>
                <tr><td>Band 2</td><td>800 – 1,500</td></tr>
                <tr><td>Band 3</td><td>1,500 – 2,500</td></tr>
                <tr><td>Band 4</td><td>2,500 – 4,000</td></tr>
              </tbody>
            </table>
          </div>
        </div>
        <div class="card">
          <h3>Frequency Bands — Firetruck <span aria-hidden="true">🚒</span></h3>
          <div class="table" role="region" aria-label="firetruck frequency bands">
            <table>
              <thead>
                <tr><th>Band</th><th>Range (Hz)</th></tr>
              </thead>
              <tbody>
                <tr><td>Band 1</td><td>300 – 600</td></tr>
                <tr><td>Band 2</td><td>600 – 1,200</td></tr>
                <tr><td>Band 3</td><td>1,200 – 2,500</td></tr>
                <tr><td>Band 4</td><td>2,500 – 4,000</td></tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </section>

    <section class="section">
      <h2>Implementation <span aria-hidden="true">⚙️</span></h2>
      <div class="grid grid-3">
        <div class="card">
          <h3>Filter Design <code>design_filters.m</code> <span aria-hidden="true">🎛️</span></h3>
          <ul>
            <li>6th‑order Butterworth band‑pass filters</li>
            <li>Frequency response analysis</li>
          </ul>
        </div>
        <div class="card">
          <h3>Feature Extraction <code>extract_features.m</code> <span aria-hidden="true">🧠</span></h3>
          <ul>
            <li>Energy ratio <code>E_amb / E_fire</code> <span aria-hidden="true">🔋</span></li>
            <li>Temporal features: ZCR, RMS <span aria-hidden="true">⏱️</span></li>
            <li>Spectral centroid</li>
          </ul>
        </div>
        <div class="card">
          <h3>Machine Learning <code>train_classifier.m</code> <span aria-hidden="true">🤖</span></h3>
          <ul>
            <li>SVM with RBF kernel</li>
            <li>5‑fold cross‑validation <span aria-hidden="true">✅</span></li>
          </ul>
        </div>
      </div>
    </section>

    <section class="section">
      <h2>Repository Structure <span aria-hidden="true">📂</span></h2>
      <pre aria-label="repository tree"><code>📁 root/
├── 📄 <b>main.m</b>                 # Main workflow script
├── 📁 scripts/
│   ├── design_filters.m       # Bandpass filter design
│   ├── extract_features.m     # Feature extraction
│   ├── train_classifier.m     # SVM training
│   └── evaluate_classifier.m  # Performance evaluation
├── 📁 audio_samples/          # Example .wav files
└── 📁 results/                # Output visualizations
</code></pre>
    </section>

    <section class="section">
      <h2>Requirements <span aria-hidden="true">🔧</span></h2>
      <div class="grid grid-3">
        <div class="stat"><div class="label">MATLAB</div><div class="value">R2021a+</div></div>
        <div class="stat"><div class="label">Toolbox</div><div class="value">Signal Processing</div></div>
        <div class="stat"><div class="label">Toolbox</div><div class="value">Statistics &amp; ML</div></div>
      </div>
    </section>

    <section class="section">
      <h2>Usage <span aria-hidden="true">🖥️</span></h2>
      <ol>
        <li>Clone the repository</li>
        <li>Add the project directory to the MATLAB path</li>
        <li>Run <kbd>main.m</kbd> to execute the full pipeline</li>
      </ol>
      <p class="badge" aria-label="performance badge">Fast Inference: &lt; 5 ms/sample</p>
    </section>

    <section class="section">
      <h2>License <span aria-hidden="true">⚖️</span></h2>
      <p>MIT License</p>
      <p class="footer">© Your Name. Feel free to adapt this template to your project.</p>
    </section>
  </div>
</body>
</html>
