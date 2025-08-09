# Color Tap Generator

[![style: solid](https://img.shields.io/badge/style-solid-orange)](https://pub.dev/packages/solid_lints)

A simple Flutter app developed as part of a job application test. The goal of this task is to demonstrate Flutter development skills, code organization, and testing practices.

## Overview

The Color Tap Generator is a fun and lightweight application where users can tap the screen to generate random colors. It also shows a list of recently generated colors.

## Features

* Generate random colors with a tap
* Display the current color details (HEX)
* Maintain a strip of recently generated colors
* Simple, responsive UI

## Project Structure

As this is a small task, the project is organized according to the principles of a simple, layered architecture:

* `core/` – Utility classes and helper functions
* `presentation/` – Widgets and UI components
* `color_generator_app.dart` – The main application widget
* `main.dart` – App entry point

## Installation

1. Clone the repository

```bash
git clone https://github.com/khedrmahmoud/flutter_color_generator.git
```

2. Navigate to the project directory

```bash
cd flutter_color_generator
```

3. Install dependencies

```bash
flutter pub get
```

4. Run the app

```bash
flutter run
```

## Testing

This project includes unit, widget, and integration tests to ensure quality.

```bash
# Unit & Widget tests 
flutter test --reporter expanded

# Integration tests 
flutter test integration_test --reporter expanded
```

## Notes

* This project was created as part of a job application to demonstrate coding style, Flutter knowledge, and testing skills.
* The code is intentionally simple and focuses on clarity and correctness rather than implementing complex architectural patterns.
