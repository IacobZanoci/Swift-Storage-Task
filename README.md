# SwiftStorageTask

This is a Swift command-line project that implements a simple in-memory product storage system with basic CRUD operations.

## 📦 Features

- Add new products (with unique `id`)
- Delete products by `id`
- Search for products by name (with producer disambiguation)
- Search for products by producer (sorted alphabetically)
- Case-insensitive search
- In-memory storage (no database or file storage)

## 🧩 Structure

- `Product`: Struct representing a product with `id`, `name`, and `producer`
- `Shop` protocol: Defines the required methods for managing products
- `ShopImpl` class: Implements the `Shop` protocol using an in-memory dictionary

## ✅ Requirements

- macOS with Swift 5.0 or higher installed
- Xcode (recommended) or any Swift-compatible IDE
- Command-line Swift project setup

## ▶️ How to Run

1. Open the project folder in Xcode.
2. Make sure `main.swift` is set as the entry point.
3. Press **Run** (`Cmd + R`) to build and execute the program.
4. Output will appear in the Xcode console.
