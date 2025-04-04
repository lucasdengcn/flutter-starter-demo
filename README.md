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
  - Token refresh mechanism

- **Environment Configuration**
  - Multiple environment support (.env files)
  - Development, Staging, UAT, and Production environments
  - Environment-specific API configurations

- **Responsive Design**
  - Adaptive layout for different screen sizes
  - Responsive UI components using flutter_screenutil
  - SVG rendering and manipulation using flutter_svg

- **Localization**
  - Supports multiple languages
  - Language selection and translation management

- **Error Handling**
  - Global error handling mechanism
  - Custom error types and messages
  - Error logging and reporting

- **Unit Testing**
  - Comprehensive unit test coverage for critical components
  - Mocking and stubbing for external dependencies
  - Test-driven development (TDD) approach

- **Image Picker**
  - Allows users to select and upload images from their device
  - Image compression and optimization

- **QR Code Generation**
  - Generates QR codes for sharing and scanning
  - QR code scanning functionality

- **Notification System**
  - Push notifications for upcoming events and reminders
  - Local notifications for timely reminders

- **User Profile**
  - User profile management
  - Profile picture upload and display
  - User information editing

- **Video Player**
  - Plays videos from URLs or local sources
  - Video playback controls
  - Video quality selection

- **Audio Player**
  - Plays audio files from URLs or local sources
  - Audio playback controls
  - Audio quality selection

- **Background Services**
  - Runs in the background for location tracking and notification scheduling

- **Charts**
  - Displays data using charts
  - Customizable chart types and styles

- **Real time**
  - Connects to a WebSocket server for real-time data updates
  - SSE (Server-Sent Events) support

- **Geolocation**
  - Retrieves user's current location
  - Displays location information on the map

## Development Practices

- **Modularization**: Code organized by features for better maintainability
- **Singleton Pattern**: Used for services that need to maintain a single state
- **MVVM+S Pattern**: Clear separation of concerns between data, logic, and UI
- **Dependency Injection**: Using GetIt for service location and dependency management

### MVVM Pattern

The MVVM+S pattern is a design pattern used in software development to separate the user interface (View) from the business logic (Model) and the presentation logic (ViewModel) and the integration logic (Service). It provides a clear separation of concerns and promotes a more maintainable and testable codebase.
In this project, the MVVM pattern is implemented as follows:

- **Model**: Represents the data and business logic of the application. It contains the data structures and methods related to the domain.
- **Service**: Represents the integration logic of the application. It contains the methods related to the external API.
- **View**: Represents the user interface components and their layout. It displays the data and handles user interactions.
- **ViewModel**: Acts as a mediator between the Model and the View. It handles the presentation logic, transforms data from the Model into a format suitable for the View, and handles user interactions.
The MVVM pattern promotes the following principles:
- **Separation of Concerns**: Each component (Model, View, ViewModel) has a specific responsibility and is isolated from the others.
- **Testability**: The ViewModel is typically unit-tested, allowing for isolated testing of the presentation logic.
- **Reusability**: The ViewModel can be reused across different Views, promoting code reuse and reducing duplication.
- **Scalability**: The separation of concerns allows for easier scaling and maintenance of the codebase.
- **Modularity**: The pattern promotes modularization of the codebase, making it easier to understand and maintain.
- **Decoupling**: The ViewModel decouples the View from the Model, allowing for independent development and testing.

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
