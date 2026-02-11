# Grapevine Disease Detection App

A Flutter-based mobile application that detects grapevine leaf diseases using a trained deep learning model. The model is integrated into the app, allowing fast and practical disease prediction from leaf images.

This project demonstrates the combination of **mobile development** and **machine learning** to solve real-world problems.

---

## 🚀 Features

*  Upload grape leaf images.
*  On-device disease prediction using the model.
*  Lightweight interface
---

## Machine Learning Model

The disease detection model was developed in **Python using Jupyter Notebook** and trained on a dataset sourced from **Kaggle**.

### Tech Stack:

* NumPy — numerical operations
* TensorFlow & Keras — model building and training
* Matplotlib — training visualization

After training, the model was exported and added to the Flutter project under the **assets/** directory for seamless integration.

---

## 📂 Project Structure

```
GRAPEVINE_DISEASE-DETECTION/
│
├── assets/            # Contains the trained model
├── lib/               # contains the flutter  application code
├── android/           # Android  files
├── ios/               # iOS  files
├── web/               # Web files
├── linux/ macos/      # Desktop files
├── test/              # Unit and widget tests
│
├── pubspec.yaml       # Project dependencies
└── README.md
```
---

## ⚙️ Getting Started

Make sure you have installed:

* Flutter SDK
* Dart
* Android Studio / VS Code
* Emulator or Physical Device

Check installation:

```bash
flutter doctor
```

---

### Installation

Clone the repository:

```bash
git clone https://github.com/ayushh-gautamm/GRAPEVINE_DISEASE-DETECTION.git
cd GRAPEVINE_DISEASE-DETECTION
```

Install dependencies:

```bash
flutter pub get
```

Run the app:

```bash
flutter run
```

---

## 🔮 Future Improvements

* Improve model accuracy with larger datasets
* Add offline prediction capability
* Enhance UI/UX
* Expand support for more plant diseases

---

## 👨‍💻 Author

**Ayush Gautam**

If you found this project useful, consider giving it a ⭐ on GitHub!
