# Emergency Vehicle Sound Classification System 🚨

A MATLAB-based machine learning system for classifying ambulance (🚑) and firetruck (🚒) sounds using digital signal processing techniques.

## Technical Overview 📊

- **Classification Accuracy**: 86.15% (Test) | 94.61% (Cross-Validation)
- **Processing Time**: <5ms per sample ⚡
- **Frequency Bands**:
  - Ambulance: 300-800Hz, 800-1500Hz, 1500-2500Hz, 2500-4000Hz
  - Firetruck: 300-600Hz, 600-1200Hz, 1200-2500Hz, 2500-4000Hz
- **Optimal Threshold**: τ = 0.244 (MAD-optimized) 📈

## Implementation ⚙️

### Core Components
1. **Filter Design** (`design_filters.m`)
   - 6th-order Butterworth bandpass filters 🎛️
   - Frequency response analysis

2. **Feature Extraction** (`extract_features.m`)
   - Energy ratio calculation (E_amb/E_fire) 🔋
   - Temporal features (ZCR, RMS) ⏱️
   - Spectral centroid

3. **Machine Learning** (`train_classifier.m`)
   - SVM with RBF kernel 🤖
   - 5-fold cross-validation ✅

## Repository Structure 📂

📁 root/
├── 📄 main.m # Main workflow script
├── 📁 scripts/
│ ├── design_filters.m # Bandpass filter design
│ ├── extract_features.m # Feature extraction
│ ├── train_classifier.m # SVM training
│ └── evaluate_classifier.m# Performance evaluation
├── 📁 audio_samples/ # Example .wav files
└── 📁 results/ # Output visualizations

## Requirements 🔧
- MATLAB R2021a+
- Signal Processing Toolbox
- Statistics and Machine Learning Toolbox

## Usage 🖥️
1. Clone repository
2. Add project directory to MATLAB path
3. Execute `main.m` to run full pipeline

## License ⚖️
MIT License
