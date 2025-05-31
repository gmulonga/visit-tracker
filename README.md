# 📱 Visit Tracker Flutter App

A Flutter-based Visit Tracker app for managing visits, customers, and activities. The app is
structured for maintainability, with a clear separation of concerns using controller-service-model
architecture. It includes custom UI widgets, state management, and optional offline support.

---

## 📸 Screenshots

> Add images in a `/screenshots` folder and reference them here.

- ![Home Page](screenshots/home.jpeg)
- ![Add Visit](screenshots/add.jpeg)
- ![Visit Detail](screenshots/detail.jpeg)

---

## 🧱 Project Structure

lib/
├── main.dart
├── app/
│ ├── bindings/ # Dependency injection setup
│ ├── controllers/ # State management controllers
│ ├── data/
│ │ ├── models/ # Data models for Visit, Customer, Activity
│ │ └── services/ # API layer (or Firebase service)
│ ├── pages/ # UI screens
│ └── routes/ # App navigation
└── widgets/ # Custom reusable widgets


---

## 🧠 Architectural Decisions

- **MVC-ish Separation**:  
  Controllers manage state, models represent structured data, services handle API/Firebase logic.

- **Modular Structure**:  
  Code is organized by responsibility: UI, data, logic, and routing are in distinct folders.

- **Dependency Injection**:  
  `bindings/` handles controller injection to reduce tight coupling.

---

## 🚀 Getting Started

### 1. Clone the project

```bash
git clone https://github.com/gmulonga/visit-tracker.git
cd visit-tracker
```

### Install flutter packages

```bash
flutter pub get
```

### Run the app

```bash
flutter run
```
