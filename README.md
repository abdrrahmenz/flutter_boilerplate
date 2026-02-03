# Flutter Boilerplate

A production-ready Flutter boilerplate following Clean Architecture principles with BLoC state management, modular design, and comprehensive component system.

## 📋 Table of Contents

- [Features](#-features)
- [Architecture](#-architecture)
- [Project Structure](#-project-structure)
- [Getting Started](#-getting-started)
- [Module System](#-module-system)
- [State Management](#-state-management)
- [Components](#-components)
- [Development Guide](#-development-guide)
- [Best Practices](#-best-practices)
- [Contributing](#-contributing)

## ✨ Features

### Architecture & State Management
- **Clean Architecture** - Separation of concerns with data, domain, and presentation layers
- **BLoC Pattern** - Predictable state management with flutter_bloc
- **Module System** - Feature-based modular architecture with dependency injection (GetIt)

### UI & Design System
- **shadcn_ui Components** - Modern, accessible UI components ([Migration Guide](SHADCN_MIGRATION.md))
- **Geist Sans Typography** - 9 font weights for professional typography
- **Material 3 Design** - Material You with dynamic ColorScheme (light/dark themes)
- **Atomic Design** - Component library organized as Atoms, Molecules, and Organisms

### Routing & Navigation
- **go_router** - Declarative routing with deep linking support
- **Route Guards** - Authentication-based navigation with automatic redirects
- **Type-Safe Routes** - Named routes with compile-time safety
- **Navigation Tracking** - Built-in observer for debugging and analytics

### Forms & Validation
- **FormZ Integration** - Type-safe form validation
- **shadcn_ui Inputs** - Validated input components with error handling
- **Real-time Validation** - Instant feedback with proper error messages

### Infrastructure
- **Network Layer** - Dio-based HTTP client with interceptors
- **Local Storage** - Hive for offline data persistence
- **Multi-Flavor** - Development, Staging, and Production environments
- **Error Tracking** - Global error handling with RecordErrorUseCase
- **Offline Support** - Automatic caching with connectivity detection
- **Internationalization** - Multi-language support (English, Indonesian)

## 🏗️ Architecture

This project follows **Clean Architecture** with three main layers:

```
┌─────────────────────────────────────────────┐
│           Presentation Layer                │
│  (Pages, Widgets, BLoCs, FormZ)            │
└─────────────────┬───────────────────────────┘
                  │
┌─────────────────▼───────────────────────────┐
│            Domain Layer                     │
│  (Entities, UseCases, Repository Interfaces)│
└─────────────────┬───────────────────────────┘
                  │
┌─────────────────▼───────────────────────────┐
│             Data Layer                      │
│  (Models, Repositories, Data Sources)       │
└─────────────────────────────────────────────┘
```

### Layer Responsibilities

- **Presentation**: UI components, state management (BLoC), form validation (FormZ)
- **Domain**: Business logic, entities, use cases, repository contracts
- **Data**: API integration, local storage, repository implementations

## 📁 Project Structure

```
lib/
├── app/                    # Application configuration
│   ├── config.dart        # App-wide configuration
│   ├── flavor.dart        # Environment flavors (dev, stag, prod)
│   ├── locator.dart       # Dependency injection setup
│   ├── modules.dart       # Module registration
│   └── app.dart           # Root app widget
├── core/                  # Core functionality
│   ├── components/        # UI component library
│   │   ├── atom/         # Basic building blocks (Text, Skeleton)
│   │   ├── molecule/     # Composite components (Buttons, Inputs)
│   │   └── organism/     # Complex components (Cards, Pickers)
│   ├── constants/        # App-wide constants
│   ├── data/             # Core data utilities
│   ├── exceptions/       # Custom exceptions
│   ├── extensions/       # Dart/Flutter extensions
│   ├── failures/         # Error handling
│   ├── helpers/          # Helper functions
│   ├── module/           # Module system base
│   ├── networks/         # HTTP client configuration
│   ├── pages/            # Common pages (Splash, Error)
│   ├── preferences/      # Local storage
│   ├── usecases/         # Base use case classes
│   └── utils/            # Utility functions
├── features/             # Feature modules
│   ├── auth/            # Authentication feature
│   │   ├── data/
│   │   │   ├── models/
│   │   │   ├── repositories/
│   │   │   └── sources/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   ├── presentation/
│   │   │   ├── blocs/
│   │   │   ├── formz/
│   │   │   ├── pages/
│   │   │   └── widgets/
│   │   └── module.dart
│   ├── home/            # Home feature
│   └── settings/        # Settings feature
├── l10n/                # Internationalization
│   ├── app_en.arb
│   └── app_id.arb
└── main_dev.dart        # Dev environment entry point
    main_prod.dart       # Prod environment entry point
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK: `^3.10.0`
- Dart SDK: `^3.10.0`
- IDE: VS Code or Android Studio

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd flutter_boilerplate
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   # Development
   flutter run -t lib/main_dev.dart
   
   # Production
   flutter run -t lib/main_prod.dart
   ```

### Environment Configuration

The app supports multiple environments configured in `lib/app/config.dart`:

```dart
static const FlavorConfig<String> baseUrl = FlavorConfig<String>(
  prod: 'https://api.production.com',
  dev: 'https://api.development.com',
  stag: 'https://api.staging.com',
);
```

## 📦 Module System

### Creating a New Module

Each feature is a self-contained module with its own routes and dependencies.

1. **Create module structure**
   ```
   features/your_feature/
   ├── data/
   │   ├── models/
   │   ├── repositories/
   │   └── sources/
   ├── domain/
   │   ├── entities/
   │   ├── repositories/
   │   └── usecases/
   ├── presentation/
   │   ├── blocs/
   │   ├── pages/
   │   └── widgets/
   ├── module.dart
   └── your_feature.dart
   ```

2. **Implement module.dart**
   ```dart
   import 'package:go_router/go_router.dart';
   
   class YourFeatureModule implements BaseModule {
     @override
     Future<void> inject(GetIt getIt) async {
       // Register data sources
       getIt.registerLazySingleton<YourRemoteSource>(
         () => YourRemoteSourceImpl(getIt()),
       );
       
       // Register repositories
       getIt.registerLazySingleton<YourRepository>(
         () => YourRepositoryImpl(getIt()),
       );
       
       // Register use cases
       getIt.registerLazySingleton(() => GetYourDataUseCase(getIt()));
       
       // Register BLoCs
       getIt.registerFactory(() => YourBloc(getIt()));
     }
     
     @override
     List<RouteBase> routes() {
       return [
         GoRoute(
           path: '/your-feature',
           name: 'your-feature',
           builder: (context, state) => const YourPage(),
         ),
         GoRoute(
           path: '/your-feature/:id',
           name: 'your-feature-detail',
           builder: (context, state) {
             final id = state.pathParameters['id']!;
             return YourDetailPage(id: id);
           },
         ),
       ];
     }
   }
   ```

3. **Register in app/modules.dart**
   ```dart
   var appModules = <BaseModule>[
     AuthModule(),
     SettingsModule(),
     HomeModule(),
     YourFeatureModule(), // Add here
   ];
   ```

## 🔄 State Management

### BLoC Pattern

This project uses **flutter_bloc** for state management.

#### Event Example
```dart
abstract class YourEvent extends Equatable {
  const YourEvent();
  @override
  List<Object?> get props => [];
}

class LoadData extends YourEvent {
  final String? filter;
  const LoadData({this.filter});
  @override
  List<Object?> get props => [filter];
}
```

#### State Example
```dart
enum YourStatus {
  initial,
  loading,
  loaded,
  error,
  navigateToDetail,
}

class YourState extends Equatable {
  final YourStatus status;
  final List<YourModel> data;
  final String? errorMessage;
  
  const YourState({
    this.status = YourStatus.initial,
    this.data = const [],
    this.errorMessage,
  });
  
  @override
  List<Object?> get props => [status, data, errorMessage];
}
```

#### BLoC Example
```dart
class YourBloc extends Bloc<YourEvent, YourState> {
  final GetYourDataUseCase _getDataUseCase;
  
  YourBloc(this._getDataUseCase) : super(const YourState()) {
    on<LoadData>(_onLoadData);
  }
  
  Future<void> _onLoadData(
    LoadData event,
    Emitter<YourState> emit,
  ) async {
    emit(state.copyWith(status: YourStatus.loading));
    
    final result = await _getDataUseCase(event.filter);
    
    result.fold(
      (failure) => emit(state.copyWith(
        status: YourStatus.error,
        errorMessage: failure.message,
      )),
      (data) => emit(state.copyWith(
        status: YourStatus.loaded,
        data: data,
      )),
    );
  }
}
```

### Form Validation with FormZ

```dart
class EmailInput extends FormzInput<String, EmailInputError> {
  const EmailInput.pure() : super.pure('');
  const EmailInput.dirty([String value = '']) : super.dirty(value);
  
  static final _emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  
  @override
  EmailInputError? validator(String value) {
    if (value.isEmpty) return EmailInputError.empty;
    if (!_emailRegExp.hasMatch(value)) return EmailInputError.invalid;
    return null;
  }
}
```

## 🧩 Components

### shadcn_ui Design System

The project uses **shadcn_ui** for modern, accessible components. See [SHADCN_MIGRATION.md](SHADCN_MIGRATION.md) for complete migration details.

#### Text Styling with Context Helpers

```dart
import 'package:flutter_boilerplate/core/core.dart';

// Typography
Text('Heading 1', style: context.h1)
Text('Heading 2', style: context.h2)
Text('Heading 3', style: context.h3)
Text('Body Large', style: context.bodyLarge)
Text('Body', style: context.body)
Text('Muted text', style: context.muted)
Text('Label', style: context.label)
Text('Caption', style: context.caption)
```

#### Buttons (shadcn_ui)

```dart
import 'package:shadcn_ui/shadcn_ui.dart';

// Primary button
ShadButton(
  onPressed: () {},
  child: const Text('Submit'),
)

// Button variants
ShadButton.outline(onPressed: () {}, child: const Text('Cancel'))
ShadButton.ghost(onPressed: () {}, child: const Text('Skip'))
ShadButton.destructive(onPressed: () {}, child: const Text('Delete'))
ShadButton.secondary(onPressed: () {}, child: const Text('Secondary'))
ShadButton.link(onPressed: () {}, child: const Text('Link'))

// Button sizes
ShadButton(size: ShadButtonSize.sm, ...)
ShadButton(size: ShadButtonSize.lg, ...)

// Full width button
ShadButton(
  width: double.infinity,
  onPressed: () {},
  child: const Text('Full Width'),
)

// With icon
ShadButton(
  leading: const Icon(Icons.add),
  onPressed: () {},
  child: const Text('Add Item'),
)
```

#### Input Components (shadcn_ui)

```dart
// Text input
ShadTextInput(
  label: 'Email',
  controller: emailController,
  errorText: state.email.errorMessage,
  keyboardType: TextInputType.emailAddress,
)

// Password input
ShadPasswordInput(
  label: 'Password',
  controller: passwordController,
  errorText: state.password.errorMessage,
)

// Search input
ShadSearchInput(
  placeholder: 'Search...',
  onChanged: (value) => bloc.add(SearchEvent(query: value)),
)

// FormZ integration
buildShadTextInput(
  context: context,
  label: 'Email',
  formzInput: state.email,
  onChanged: (value) => bloc.add(EmailChanged(value)),
)
```

#### Switch Component

```dart
ShadSwitch(
  value: isEnabled,
  onChanged: (value) => setState(() => isEnabled = value),
)
```

### Custom Components (Preserved)

#### Atoms
- `Skeleton`, `SkeletonAnimation` - Loading placeholders with shimmer effect

#### Molecules
- `RadioCircle` - Custom radio button (updated with shadcn theming)
- `InputLabel` - Form input label with required indicator
- `ContentSheet` - Bottom sheet with drag handle
- `PhoneTextInput` - Phone number input with country picker
- `OtpTextInput` - PIN/OTP input field
- `DropdownInput` - Dropdown selector
- `EditableTextInput` - Inline editable text

#### Organisms
- `CardShadow` - Elevated card with shadow (updated with shadcn theming)
- `CardTicket` - Ticket-style card with decorative edges
- `EmptyWidget` - Empty state display
- `LoadingComponent` - Loading indicator with text
- `SmartNetworkImage` - Cached network image with error handling
- `BottomSheetImagePicker` - Image picker (camera/gallery)
- `DottedBorder` - Dotted border container
- `BlinkAnimation` - Blinking animation effect
- `ChipWidget` - Chip/tag component

### Using Components

```dart
import 'package:flutter_boilerplate/core/core.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Card with content
CardShadow(
  child: Column(
    children: [
      Text('Title', style: context.h3),
      const SizedBox(height: 8),
      Text('Description', style: context.body),
    ],
  ),
)

// Empty state
EmptyWidget(message: 'No items found')

// Loading state
LoadingComponent()

// Skeleton loading
Skeleton(width: 200, height: 20)
SkeletonAnimation(child: /* your content */)
```

## 🛠️ Development Guide

### Creating a New Feature

Follow these steps to add a new feature:

1. **Create feature structure**
   ```bash
   mkdir -p lib/features/products/{data,domain,presentation}/{models,entities,blocs,pages}
   ```

2. **Define entities** (domain/entities/)
   ```dart
   class Product extends Equatable {
     final String id;
     final String name;
     final double price;
     
     const Product({required this.id, required this.name, required this.price});
     
     @override
     List<Object?> get props => [id, name, price];
   }
   ```

3. **Create repository interface** (domain/repositories/)
   ```dart
   abstract class ProductRepository {
     Future<Either<Failure, List<Product>>> getProducts();
   }
   ```

4. **Implement use cases** (domain/usecases/)
   ```dart
   class GetProductsUseCase extends UseCase<List<Product>, NoParams> {
     final ProductRepository repository;
     GetProductsUseCase(this.repository);
     
     @override
     Future<Either<Failure, List<Product>>> call(NoParams params) {
       return repository.getProducts();
     }
   }
   ```

5. **Create data models** (data/models/)
   ```dart
   @JsonSerializable()
   class ProductModel {
     final String id;
     final String name;
     final double price;
     
     Product toEntity() => Product(id: id, name: name, price: price);
   }
   ```

6. **Implement repository** (data/repositories/)
   ```dart
   class ProductRepositoryImpl implements ProductRepository {
     final ProductRemoteSource remoteSource;
     
     @override
     Future<Either<Failure, List<Product>>> getProducts() async {
       try {
         final result = await remoteSource.getProducts();
         return Right(result.map((m) => m.toEntity()).toList());
       } on ServerException catch (e) {
         return Left(ServerFailure(message: e.message));
       }
     }
   }
   ```

7. **Create BLoC** (presentation/blocs/)
8. **Build UI** (presentation/pages/)
9. **Register module** (module.dart)
10. **Add to app/modules.dart**

### Navigation with go_router

Declarative navigation using go_router:

```dart
// Navigate by path
context.go('/products');

// Navigate with parameters
context.go('/products/123');

// Navigate by name
context.goNamed('product-detail', pathParameters: {'id': '123'});

// Push (keep previous route)
context.push('/settings');

// Pop
context.pop();

// Replace current route
context.replace('/login');

// Pass extra data
context.push('/edit-profile', extra: {'user': userModel});

// Query parameters
context.go('/search?q=flutter&category=mobile');
```

#### Route Guards & Authentication

Automatic redirects based on authentication status:

```dart
// In app_router.dart
redirect: (BuildContext context, GoRouterState state) {
  final authBloc = GetIt.I<AuthBloc>();
  final isAuthorized = authBloc.state.status == AuthStateStatus.authorized;
  
  // Redirect unauthorized users to login
  if (!isAuthorized && !state.matchedLocation.startsWith('/auth')) {
    return '/auth/login?redirect=${Uri.encodeComponent(state.matchedLocation)}';
  }
  
  // Redirect authorized users away from auth pages
  if (isAuthorized && state.matchedLocation.startsWith('/auth')) {
    return '/home';
  }
  
  return null; // No redirect
};
```

#### Type-Safe Routes

Define routes in `route_utils.dart`:

```dart
enum AppRoute {
  splash('/splash', 'splash'),
  login('/auth/login', 'login'),
  register('/auth/register', 'register'),
  home('/home', 'home'),
  profile('/profile', 'profile'),
  settings('/settings', 'settings');
  
  const AppRoute(this.path, this.name);
  final String path;
  final String name;
}

// Usage
context.go(AppRoute.home.path);
context.goNamed(AppRoute.profile.name);
```

### Internationalization

Add translations in `lib/l10n/`:

```json
// app_en.arb
{
  "welcome": "Welcome",
  "login": "Login"
}

// app_id.arb
{
  "welcome": "Selamat Datang",
  "login": "Masuk"
}
```

Use in code:
```dart
Text(context.l10n.welcome)
```

### Error Handling

All errors should use the `Failure` pattern:

```dart
result.fold(
  (failure) {
    // Handle error
    if (failure is ServerFailure) {
      // Network error
    } else if (failure is CacheFailure) {
      // Cache error
    }
  },
  (data) {
    // Handle success
  },
);
```

## 📚 Best Practices

1. **Module Independence** - Each feature module should be self-contained
2. **Clean Architecture** - Maintain strict layer separation
3. **BLoC Pattern** - All business logic goes in BLoCs, not widgets
4. **FormZ Validation** - Use FormZ for all form validations
5. **Error Handling** - Always use Either<Failure, Success> pattern
6. **Component Reuse** - Use existing components before creating new ones
7. **Naming Conventions** - Follow Dart naming conventions
8. **Documentation** - Document complex logic and public APIs
9. **Testing** - Write unit tests for business logic
10. **Code Generation** - Run build_runner after model changes

### Code Style

- Use trailing commas for better formatting
- Keep functions small and focused
- Prefer composition over inheritance
- Use const constructors where possible
- Follow the DRY principle

## 📝 Available Scripts

```bash
# Run development build
flutter run -t lib/main_dev.dart

# Run production build
flutter run -t lib/main_prod.dart

# Generate code
flutter pub run build_runner build --delete-conflicting-outputs

# Watch for changes and generate code
flutter pub run build_runner watch --delete-conflicting-outputs

# Run tests
flutter test

# Analyze code
flutter analyze

# Format code
dart format lib/

# Clean build
flutter clean && flutter pub get
```

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/features/auth/domain/usecases/login_usecase_test.dart

# Run with coverage
flutter test --coverage
```

## 📦 Key Dependencies

### Core
- **flutter_bloc** (^9.1.1) - State management with BLoC pattern
- **get_it** (^8.3.0) - Service locator for dependency injection
- **go_router** (^14.6.1) - Declarative routing with deep linking
- **equatable** (^2.0.7) - Value equality for Dart objects

### UI & Design
- **shadcn_ui** (^0.45.1) - Modern UI component library
- **adaptive_theme** (^3.6.0) - Dark/light theme switching
- **flutter_svg** (^2.0.17) - SVG rendering

### Networking & Data
- **dio** (^5.9.0) - HTTP client with interceptors
- **dartz** (^0.10.1) - Functional programming (Either, Option)
- **hive** (^2.2.3) - Fast NoSQL local database
- **connectivity_plus** (^6.1.5) - Network connectivity detection

### Forms & Validation
- **formz** (^0.8.0) - Type-safe form validation
- **json_annotation** (^4.9.0) - JSON serialization annotations
- **json_serializable** (^6.11.2) - Code generation for JSON

### Utilities
- **cached_network_image** (^3.4.1) - Image caching
- **image_picker** (^1.1.2) - Camera and gallery picker
- **file_picker** (^10.3.8) - File selection
- **flutter_image_compress** (^2.3.0) - Image compression

## 🤝 Contributing

1. Create a feature branch from `develop`
2. Follow the architecture and coding standards
3. Write tests for new features
4. Update documentation
5. Create a pull request

## 📄 License

This project is licensed under the MIT License.

## 🆘 Support

For issues and questions:
- Check existing documentation
- Review similar implementations in existing features
- Consult the Copilot instructions in `.github/copilot-instructions.md`

---

**Happy Coding! 🚀**