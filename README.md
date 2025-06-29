# 📸 Image Album App

A Flutter app that fetches albums and their images using BLoC pattern, with local caching, pagination, and a clean architecture approach. Built as part of an assignment to demonstrate scalable, testable app architecture.

---

## ⚙️ Tech Stack

- **Flutter** (Dart 3)
- **flutter_bloc** for reactive state management
- **Hive** for local storage
- **GetIt** for dependency injection
- **Dio** for networking
- **CachedNetworkImage** for optimized image loading

----

## 📁 Folder Structure

```
lib/
├── core/
│   ├── config/
│   │   ├── environment/
│   │   └── network_config/
│   ├── di/
│   ├── loggers/
│   └── service/
│       ├── local_storage_service/
│       │   └── hive_service/
│       └── remote_service/
│           ├── api_request/
│           └── api_service/
│
├── data.images_album/
│   ├── dataSources/
│   ├── models/
│   └── repository/
│
├── domain.image_album/
│   ├── entity/
│   ├── repository/
│   └── usecase/
│
├── presentation/
│   ├── helper/
│   └── image_album/
│       ├── bloc/
│       └── screens/widgets/
│
└── main.dart
```

## 🧱 Architecture

This project follows **Clean Architecture** principles and separates the app into layers:

### 1. **Core Layer**
- Handles environment config, dependency injection, networking, logging, and abstract service interfaces.
- Ensures reusable infrastructure setup for any feature module.

### 2. **Data Layer**
- Responsible for fetching raw data (remote/local).
- Contains:
   - `RemoteDataSource` using API Service
   - `LocalDataSource` using Hive
   - DTO Models
   - Repository implementation

### 3. **Domain Layer**
- Business logic lives here.
- Includes:
   - Entity classes (pure Dart models)
   - Repository contracts (abstract interfaces)
   - Use cases for albums and image retrieval

### 4. **Presentation Layer**
- Uses BLoC pattern for state management.
- Modular UI split into screens and reusable widgets.
- Pagination, image grid view, and offline state handling are implemented.

## ✅ Key Features

- 🔄 **Pagination Support** for both Albums and Images
- 💾 **Offline Caching** with Hive using abstract storage layer
- 🧱 **Clean Architecture** with strict separation of concerns
- 📦 **Dependency Injection** via DI container
- 📷 **Cached Network Images** with graceful error and loading states
- ⚙️ **Flexible API Configuration** with environment switching
- 🧪 **BLoC Unit Tests** with mock use cases
- 🎯 **Dart 3** and **Flutter Best Practices**

## 🚀 How to Run

```bash
flutter pub get
flutter run
```

## 🧪 Running Tests

```bash
flutter test
```

## 📌 Notes

- Add your API base URLs in `env_config.dart`
- Make sure Hive is properly initialized in your main entry point.


## 🚀 Pagination Strategy

- Album list fetched page-wise using `FetchAlbums(fetchNextPage: true)`
- Album images fetched per album + page using `LoadImagesForAlbum(albumId, fetchNextPage: true)`
- Each page stored in Hive under a box and key combination like:
    - `album_page_1`
    - `images_album_{albumId}_page_2`

---

## 🧪 Testing

- Mocked `GetAlbumUseCase` and `GetImagesUseCase` using `mocktail`.
- Tested both initial load and pagination behavior of `ImageAlbumBloc`.


## 📷 Sample UI
![img_1.png](img_1.png)

---

## 👤 Author

Avijit Goswami  
📧 [avijitgoswami72@gmail.com]
💼 [https://github.com/foolishGeek]

## 📄 License

This project is licensed under the MIT License.
