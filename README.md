# Flutter Starter Demo

A Flutter mobile application for starter with a focus on clean architecture and modular design.

## Tech Stack

- **Flutter**: Cross-platform UI toolkit for building natively compiled applications
- **Dart**: Programming language optimized for building mobile, desktop, server, and web applications
- **Provider**: State management solution for Flutter applications
- **GetIt**: Service locator for dependency injection
- **Go Router**: Declarative routing package for Flutter that uses the Router API
- **json_serializable**: Code generation for model serialization and deserialization
- **flutter_secure_storage**: Secure storage implementation using platform-specific encryption
- **flutter_dotenv**: Environment configuration management for multiple deployment environments
- **flutter_screenutil**: Responsive UI adaptation for different screen sizes
- **flutter_svg**: SVG rendering and manipulation support

## Architecture Pattern

This project follows the MVVM (Model-View-ViewModel) architecture pattern:

- **Model**: Data and business logic layer
- **View**: UI layer (screens and widgets)
- **ViewModel**: Mediator between Model and View, handling UI logic and state management

## Project Structure

The project is organized using a feature-first approach:

```
lib/
  ├── core/            # Core functionality shared across features
  │   ├── providers/   # Provider configurations
  │   ├── routes/      # Application routing
  │   ├── service/     # Core services including service locator
  │   ├── viewmodel/   # Base viewmodel classes
  │   └── widgets/     # Shared UI components
  ├── features/        # Feature modules
  │   ├── prayer/      # Prayer feature implementation
  │   │   ├── model/   # Data models for prayer feature
  │   │   ├── service/ # Services for prayer feature
  │   │   └── viewmodel/ # ViewModels for prayer feature
  │   ├── signin/      # Sign-in feature implementation
  │   │   ├── service/ # Services for signin feature
  │   │   └── viewmodel/ # ViewModels for signin feature
  │   └── signup/      # Sign-up feature implementation
  │       ├── model/   # Data models for signup feature
  │       ├── service/ # Services for signup feature
  │       └── viewmodel/ # ViewModels for signup feature
  ├── screens/         # UI screens for each feature
  │   ├── prayer/      # Prayer screens
  │   │   └── widgets/ # Prayer-specific widgets
  │   ├── signin/      # Sign-in screens
  │   └── signup/      # Sign-up screens
  └── main.dart        # Application entry point
```

### Service Layer

The service layer is a critical component of our architecture, responsible for:

- **API Integration**: Handling all external API calls, including request formatting, response parsing, and error handling
- **Business Logic**: Implementing core business rules and domain-specific logic
- **Data Operations**: Managing data transformations, validations, and persistence
- **State Management**: Providing data to ViewModels in a format ready for UI consumption

Each feature has its own dedicated service classes that encapsulate these responsibilities, promoting separation of concerns and making the codebase more maintainable and testable.

## Features

- **Authentication**
  - User signup with phone verification
  - User signin with secure token management
  - JWT-based authentication flow
  - Secure token storage using platform-specific encryption

- **Prayer Tracking**
  - Daily prayer schedule management
  - Prayer time notifications
  - Qibla direction indicator
  - Prayer history tracking
  - Custom prayer reminders

- **Environment Configuration**
  - Multiple environment support (.env files)
  - Development, Staging, UAT, and Production environments
  - Environment-specific API configurations

## Development Practices

- **Modularization**: Code organized by features for better maintainability
- **Singleton Pattern**: Used for services that need to maintain a single state
- **MVVM Pattern**: Clear separation of concerns between data, logic, and UI
- **Dependency Injection**: Using GetIt for service location and dependency management

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK (latest stable version)
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the application

### Build Runner

1. Run `flutter pub run build_runner build --delete-conflicting-outputs` to generate json_serializable files

## Security

### Authentication & Token Management

- **Secure Token Storage**: Implements encrypted storage using flutter_secure_storage
- **Platform-Specific Encryption**: Uses Android EncryptedSharedPreferences and iOS Keychain
- **JWT Token Management**: Handles secure storage and retrieval of authentication and refresh tokens

### Data Protection

- **Encrypted Storage**: All sensitive data is encrypted at rest
- **Secure Communication**: API communications use HTTPS protocol
- **Access Control**: Implements token-based authentication for protected endpoints

## Resources

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
