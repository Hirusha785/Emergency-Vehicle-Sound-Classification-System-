# **Emergency Vehicle Sound Classification System** 🚨

A **MATLAB-based machine learning system** for classifying **ambulance** (🚑) and **firetruck** (🚒) siren sounds using digital signal processing and SVM classifiers.

**Technical Overview 📊**

- **Classification Accuracy:** `86.15%` (**Test**) | `94.61%` (**Cross-Validation**)
- **Processing Time:** `< 5 ms` per sample ⚡
- **Frequency Bands:**
  - **Ambulance:** `300–800Hz`, `800–1500Hz`, `1500–2500Hz`, `2500–4000Hz`
  - **Firetruck:** `300–600Hz`, `600–1200Hz`, `1200–2500Hz`, `2500–4000Hz`
- **Optimal Threshold:** τ = `0.244` (**MAD-optimized**) 📈

## **Implementation ⚙️**

#### **1. Filter Design** — `design_filters.m` 🎛️
- **6th-order Butterworth band-pass filters**
- **Frequency response analysis**

#### **2. Feature Extraction** — `extract_features.m` 🧠
- **Energy ratio** `E_amb / E_fire` 🔋
- **Temporal features:** ZCR, RMS ⏱️
- **Spectral centroid**

#### **3. Machine Learning** — `train_classifier.m` 🤖
- **SVM with RBF kernel**
- **5-fold cross-validation** ✅


## **Repository Structure 📂**

<img width="967" height="311" alt="image" src="https://github.com/user-attachments/assets/1759eee4-3edc-4a9a-8903-152163a4e9b7" />

## **Requirements 🔧**
- **MATLAB** R2021a+
- **Signal Processing Toolbox**
- **Statistics and Machine Learning Toolbox**


## **Usage 🖥️**
1. **Clone** the repo
2. Open **MATLAB**
3. Add the repo to your path
4. Run **`main.m`**
5. View classification results in `/results`:

## **License ⚖️**
- MIT License
