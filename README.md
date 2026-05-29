# Expense Tracker

A simple mobile finance management application built with Flutter and SQLite.

The application allows users to:

* create an account
* log into the system
* add income and expense transactions
* view transaction history
* track balance, income, and expenses

---

# Features

## Authentication System

* User registration
* User login
* Local authentication using SQLite

## Transaction Management

* Add transactions
* Income / Expense types
* Categories
* Transaction history list

## Balance Analytics

* Total balance calculation
* Total income
* Total expense

## Local Database

* SQLite integration
* Relational database structure
* User-specific transactions

---

# Technologies Used

* Flutter
* Dart
* SQLite
* sqflite
* sqflite_common_ffi
* path

---

# Project Structure

```bash
lib/
│
├── database/
│   └── database.dart
│
├── models/
│   ├── user_model.dart
│   └── transaction_model.dart
│
├── widgets/
│   ├── login_widget.dart
│   ├── register_widget.dart
│   ├── home_widget.dart
│   ├── add_transaction_widget.dart
│   ├── welcome_widget.dart
│   └── profile_widget.dart
│
└── main.dart
```

---

# Database Structure

## Users Table

| Column   | Type    |
| -------- | ------- |
| id       | INTEGER |
| username | TEXT    |
| password | TEXT    |

---

## Transactions Table

| Column   | Type    |
| -------- | ------- |
| id       | INTEGER |
| user_id  | INTEGER |
| title    | TEXT    |
| amount   | REAL    |
| type     | TEXT    |
| category | TEXT    |
| date     | TEXT    |

---

# Application Flow

```text
Welcome Screen
      ↓
Login / Register
      ↓
Home Screen
      ↓
Add Transaction
```

---

# Screens

## Welcome Screen

* Introduction page
* Navigation to Login/Register

## Login Screen

* Username input
* Password input
* SQLite authentication

## Register Screen

* Create account
* Password confirmation

## Home Screen

* Balance card
* Income / Expense statistics
* Transaction list

## Add Transaction Screen

* Add new transaction
* Select category
* Select transaction type

---

# Installation

## Clone Repository

```bash
git clone <repository-url>
```

---

## Install Dependencies

```bash
flutter pub get
```

---

## Run Application

```bash
flutter run
```

---

# Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter

  sqflite:
  sqflite_common_ffi:
  path:
```