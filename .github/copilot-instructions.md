# Flutter Project - Copilot Instructions

You are an AI assistant working on the Flutter project. This project follows clean architecture with BLoC state management and a comprehensive component system. Follow these guidelines strictly.

## 🏗️ Project Architecture

### Clean Architecture Layers
```
lib/
├── app/
│   ├── config/          # App configuration (themes, routes, etc)
│   ├── modules.dart     # Module registration
│   ├── data/           # Data layer
│   │   ├── models/     # Data models
│   │   ├── providers/  # API providers
│   │   └── services/   # External services
│   ├── domain/         # Domain layer
│   │   ├── entities/   # Business entities
│   │   ├── repositories/ # Repository interfaces
│   │   └── usecases/   # Business logic
│   └── presentation/   # Presentation layer
│       ├── modules/    # Feature modules
│       ├── shared/     # Shared UI components
│       └── widgets/    # Common widgets
├── core/              # Core functionality
│   ├── components/    # Reusable UI components
│   ├── constants/     # App constants
│   ├── helpers/       # Helper functions
│   ├── module/        # Module system
│   ├── theme/         # Theme configuration
│   └── utils/         # Utilities
├── features/          # Feature modules
└── main.dart
```

### Module Structure
Each feature module follows this pattern:
```
features/[feature_name]/
├── data/
│   ├── models/
│   ├── repositories/
│   └── sources/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── presentation/
│   ├── pages/
│   ├── blocs/
│   └── widgets/
├── module.dart         # Module configuration
└── [feature].dart      # Barrel export
```

## 🛣️ Module-Based Routing

### Module Implementation
```dart
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../core/core.dart';
import '[feature_name].dart';

class ExampleModule implements BaseModule {
  @override
  Future inject(GetIt getIt) async {
    // Data Layer
    getIt
      ..registerLazySingleton<ExampleRemoteSource>(
        () => ExampleRemoteSourceImpl(getIt()),
      )
      ..registerLazySingleton<ExampleLocalSource>(
        () => ExampleLocalSourceImpl(getIt()),
      )
      ..registerLazySingleton<ExampleRepository>(
        () => ExampleRepositoryImpl(
          remoteSource: getIt(),
          localSource: getIt(),
        ),
      );

    // Domain Layer
    getIt
      ..registerLazySingleton(() => GetExampleUseCase(getIt()))
      ..registerLazySingleton(() => CreateExampleUseCase(getIt()))
      ..registerLazySingleton(() => UpdateExampleUseCase(getIt()))
      ..registerLazySingleton(() => DeleteExampleUseCase(getIt()));

    // Presentation Layer
    getIt
      ..registerFactory(
        () => ExampleBloc(
          getExample: getIt(),
          createExample: getIt(),
          updateExample: getIt(),
          deleteExample: getIt(),
        ),
      );
  }

  @override
  Map<String, Route> routes(RouteSettings settings) {
    final args = (settings.arguments ?? {}) as Map;
    return {
      ExamplePage.routeName: MaterialPageRoute(
        builder: (_) => const ExamplePage(),
        settings: settings,
      ),
      ExampleDetailPage.routeName: CupertinoPageRoute(
        builder: (_) => ExampleDetailPage(id: args['id']),
        settings: settings,
      ),
    };
  }
}
```

### Module Registration
```dart
// In app/modules.dart
import '../features/example/module.dart';

var appModules = <BaseModule>[
  AuthModule(),
  SettingsModule(),
  HomeModule(),
  ExampleModule(), // Add your module here
];
```

## 🎯 State Management - BLoC Pattern

### Event Pattern
```dart
import 'package:equatable/equatable.dart';

abstract class ExampleEvent extends Equatable {
  const ExampleEvent();

  @override
  List<Object?> get props => [];
}

class LoadExampleData extends ExampleEvent {
  final String? filter;
  
  const LoadExampleData({this.filter});
  
  @override
  List<Object?> get props => [filter];
}

class SubmitExampleForm extends ExampleEvent {
  final Map<String, dynamic> formData;
  
  const SubmitExampleForm({required this.formData});
  
  @override
  List<Object?> get props => [formData];
}
```

### State Pattern with Navigation
```dart
import 'package:equatable/equatable.dart';

enum ExampleStatus {
  initial,
  loading,
  loaded,
  error,
  empty,
  submitting,
  submitted,
  navigateToDetail, // Navigation state
  navigateBack,     // Navigation state
}

class ExampleState extends Equatable {
  final ExampleStatus status;
  final List<ExampleModel> data;
  final String? errorMessage;
  final String? navigationId; // For navigation data
  
  const ExampleState({
    this.status = ExampleStatus.initial,
    this.data = const [],
    this.errorMessage,
    this.navigationId,
  });
  
  ExampleState copyWith({
    ExampleStatus? status,
    List<ExampleModel>? data,
    String? errorMessage,
    String? navigationId,
  }) {
    return ExampleState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
      navigationId: navigationId ?? this.navigationId,
    );
  }
  
  @override
  List<Object?> get props => [status, data, errorMessage, navigationId];
}
```

### BLoC Implementation
```dart
import 'package:flutter_bloc/flutter_bloc.dart';

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  final GetExampleUseCase _getExampleUseCase;
  final CreateExampleUseCase _createExampleUseCase;
  
  ExampleBloc({
    required GetExampleUseCase getExample,
    required CreateExampleUseCase createExample,
  }) : _getExampleUseCase = getExample,
       _createExampleUseCase = createExample,
       super(const ExampleState()) {
    on<LoadExampleData>(_onLoadExampleData);
    on<SubmitExampleForm>(_onSubmitExampleForm);
  }
  
  Future<void> _onLoadExampleData(
    LoadExampleData event,
    Emitter<ExampleState> emit,
  ) async {
    emit(state.copyWith(status: ExampleStatus.loading));
    
    final result = await _getExampleUseCase(
      GetExampleParams(filter: event.filter),
    );
    
    result.fold(
      (failure) => emit(state.copyWith(
        status: ExampleStatus.error,
        errorMessage: failure.message,
      )),
      (data) => emit(state.copyWith(
        status: data.isEmpty ? ExampleStatus.empty : ExampleStatus.loaded,
        data: data,
      )),
    );
  }
  
  Future<void> _onSubmitExampleForm(
    SubmitExampleForm event,
    Emitter<ExampleState> emit,
  ) async {
    emit(state.copyWith(status: ExampleStatus.submitting));
    
    final result = await _createExampleUseCase(
      CreateExampleParams(data: event.formData),
    );
    
    result.fold(
      (failure) => emit(state.copyWith(
        status: ExampleStatus.error,
        errorMessage: failure.message,
      )),
      (createdItem) => emit(state.copyWith(
        status: ExampleStatus.navigateToDetail,
        navigationId: createdItem.id,
      )),
    );
  }
}
```

### Navigation with BLoC Status
```dart
BlocListener<ExampleBloc, ExampleState>(
  listener: (context, state) {
    if (state.status == ExampleStatus.navigateToDetail) {
      Navigator.pushNamed(
        context,
        ExampleDetailPage.routeName,
        arguments: {'id': state.navigationId},
      );
    } else if (state.status == ExampleStatus.navigateBack) {
      Navigator.pop(context);
    }
  },
  child: YourWidget(),
)
```

## 🏛️ Repository Pattern

### Domain Layer (Repository Interface)
```dart
// In domain/repositories/example_repository.dart
import 'package:dartz/dartz.dart';
import '../../../core/core.dart';
import '../entities/entities.dart';

abstract class ExampleRepository {
  Future<Either<Failure, List<Example>>> getExamples({String? filter});
  Future<Either<Failure, Example>> getExampleById(String id);
  Future<Either<Failure, Example>> createExample(Map<String, dynamic> data);
  Future<Either<Failure, Example>> updateExample(String id, Map<String, dynamic> data);
  Future<Either<Failure, void>> deleteExample(String id);
}
```

### Data Layer (Repository Implementation)
```dart
// In data/repositories/example_repository_impl.dart
import 'package:dartz/dartz.dart';
import '../../../core/core.dart';
import '../../domain/domain.dart';
import '../data.dart';

class ExampleRepositoryImpl implements ExampleRepository {
  final ExampleRemoteSource remoteSource;
  final ExampleLocalSource localSource;
  
  ExampleRepositoryImpl({
    required this.remoteSource,
    required this.localSource,
  });
  
  @override
  Future<Either<Failure, List<Example>>> getExamples({String? filter}) async {
    try {
      // Try to get from remote
      final remoteData = await remoteSource.getExamples(filter: filter);
      
      // Cache the data
      await localSource.cacheExamples(remoteData);
      
      // Convert models to entities
      final entities = remoteData.map((model) => model.toEntity()).toList();
      
      return Right(entities);
    } on ServerException catch (e) {
      // If remote fails, try local cache
      try {
        final localData = await localSource.getCachedExamples();
        final entities = localData.map((model) => model.toEntity()).toList();
        return Right(entities);
      } on CacheException {
        return Left(ServerFailure(message: e.message));
      }
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, Example>> createExample(Map<String, dynamic> data) async {
    try {
      final result = await remoteSource.createExample(data);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
```

### Data Sources
```dart
// Remote Data Source Interface
abstract class ExampleRemoteSource {
  Future<List<ExampleModel>> getExamples({String? filter});
  Future<ExampleModel> createExample(Map<String, dynamic> data);
}

// Remote Data Source Implementation
class ExampleRemoteSourceImpl implements ExampleRemoteSource {
  final ApiProvider _apiProvider;
  
  ExampleRemoteSourceImpl(this._apiProvider);
  
  @override
  Future<List<ExampleModel>> getExamples({String? filter}) async {
    try {
      final response = await _apiProvider.get(
        '/examples',
        queryParameters: filter != null ? {'filter': filter} : null,
      );
      
      return (response.data as List)
          .map((json) => ExampleModel.fromJson(json))
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}

// Local Data Source Interface
abstract class ExampleLocalSource {
  Future<List<ExampleModel>> getCachedExamples();
  Future<void> cacheExamples(List<ExampleModel> examples);
}

// Local Data Source Implementation
class ExampleLocalSourceImpl implements ExampleLocalSource {
  final LocalStorage _localStorage;
  
  ExampleLocalSourceImpl(this._localStorage);
  
  @override
  Future<List<ExampleModel>> getCachedExamples() async {
    try {
      final cached = await _localStorage.get('cached_examples');
      if (cached != null) {
        return (cached as List)
            .map((json) => ExampleModel.fromJson(json))
            .toList();
      }
      throw CacheException(message: 'No cached data');
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
  
  @override
  Future<void> cacheExamples(List<ExampleModel> examples) async {
    await _localStorage.save(
      'cached_examples',
      examples.map((e) => e.toJson()).toList(),
    );
  }
}
```

## ✅ Form Validation with FormZ

### FormZ Input Classes
```dart
import 'package:formz/formz.dart';

// Email Input
class EmailInput extends FormzInput<String, EmailInputError> {
  const EmailInput.pure() : super.pure('');
  const EmailInput.dirty([String value = '']) : super.dirty(value);
  
  static final _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );
  
  @override
  EmailInputError? validator(String value) {
    if (value.isEmpty) return EmailInputError.empty;
    if (!_emailRegExp.hasMatch(value)) return EmailInputError.invalid;
    return null;
  }
}

enum EmailInputError { empty, invalid }

// Password Input
class PasswordInput extends FormzInput<String, PasswordInputError> {
  const PasswordInput.pure() : super.pure('');
  const PasswordInput.dirty([String value = '']) : super.dirty(value);
  
  @override
  PasswordInputError? validator(String value) {
    if (value.isEmpty) return PasswordInputError.empty;
    if (value.length < 6) return PasswordInputError.tooShort;
    return null;
  }
}

enum PasswordInputError { empty, tooShort }

// Required Input
class RequiredInput extends FormzInput<String, RequiredInputError> {
  const RequiredInput.pure() : super.pure('');
  const RequiredInput.dirty([String value = '']) : super.dirty(value);
  
  @override
  RequiredInputError? validator(String value) {
    if (value.isEmpty) return RequiredInputError.empty;
    return null;
  }
}

enum RequiredInputError { empty }
```

### Form State with FormZ
```dart
import 'package:formz/formz.dart';

class LoginFormState extends Equatable {
  final EmailInput email;
  final PasswordInput password;
  final FormzStatus status;
  final String? errorMessage;
  
  const LoginFormState({
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });
  
  LoginFormState copyWith({
    EmailInput? email,
    PasswordInput? password,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
  
  @override
  List<Object?> get props => [email, password, status, errorMessage];
}
```

### Form BLoC with FormZ
```dart
class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  final LoginUseCase _loginUseCase;
  
  LoginFormBloc({required LoginUseCase loginUseCase})
      : _loginUseCase = loginUseCase,
        super(const LoginFormState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }
  
  void _onEmailChanged(
    EmailChanged event,
    Emitter<LoginFormState> emit,
  ) {
    final email = EmailInput.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
    ));
  }
  
  void _onPasswordChanged(
    PasswordChanged event,
    Emitter<LoginFormState> emit,
  ) {
    final password = PasswordInput.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.email, password]),
    ));
  }
  
  Future<void> _onFormSubmitted(
    FormSubmitted event,
    Emitter<LoginFormState> emit,
  ) async {
    if (!state.status.isValidated) return;
    
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    
    final result = await _loginUseCase(
      LoginParams(
        email: state.email.value,
        password: state.password.value,
      ),
    );
    
    result.fold(
      (failure) => emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        errorMessage: failure.message,
      )),
      (user) => emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
      )),
    );
  }
}
```

### Form UI with FormZ
```dart
BlocBuilder<LoginFormBloc, LoginFormState>(
  builder: (context, state) {
    return Column(
      children: [
        CustomTextField(
          label: 'Email',
          onChanged: (value) => context.read<LoginFormBloc>().add(
            EmailChanged(email: value),
          ),
          errorText: state.email.invalid ? 'Invalid email' : null,
        ),
        CustomTextField(
          label: 'Password',
          obscureText: true,
          onChanged: (value) => context.read<LoginFormBloc>().add(
            PasswordChanged(password: value),
          ),
          errorText: state.password.invalid ? 'Password too short' : null,
        ),
        CustomButton(
          text: 'Login',
          isLoading: state.status.isSubmissionInProgress,
          onPressed: state.status.isValidated
              ? () => context.read<LoginFormBloc>().add(const FormSubmitted())
              : null,
        ),
        if (state.status.isSubmissionFailure)
          ErrorText(state.errorMessage ?? 'Login failed'),
      ],
    );
  },
)
```

## 🚨 Error Handling with Core

### Using Failure Classes
```dart
// Core failure classes (already in core)
abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});
  
  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({required String message}) : super(message: message);
}

class CacheFailure extends Failure {
  const CacheFailure({required String message}) : super(message: message);
}

class ValidationFailure extends Failure {
  const ValidationFailure({required String message}) : super(message: message);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure({required String message}) : super(message: message);
}
```

### Using RecordErrorUseCase
```dart
// In your BLoC
class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  final GetExampleUseCase _getExampleUseCase;
  final RecordErrorUseCase _recordErrorUseCase;
  
  ExampleBloc({
    required GetExampleUseCase getExample,
    required RecordErrorUseCase recordError,
  }) : _getExampleUseCase = getExample,
       _recordErrorUseCase = recordError,
       super(const ExampleState()) {
    on<LoadExampleData>(_onLoadExampleData);
  }
  
  Future<void> _onLoadExampleData(
    LoadExampleData event,
    Emitter<ExampleState> emit,
  ) async {
    emit(state.copyWith(status: ExampleStatus.loading));
    
    final result = await _getExampleUseCase(
      GetExampleParams(filter: event.filter),
    );
    
    result.fold(
      (failure) async {
        // Record error for monitoring
        await _recordErrorUseCase(
          RecordErrorParams(
            error: failure,
            stackTrace: StackTrace.current,
            context: 'LoadExampleData',
          ),
        );
        
        emit(state.copyWith(
          status: ExampleStatus.error,
          errorMessage: failure.message,
        ));
      },
      (data) => emit(state.copyWith(
        status: data.isEmpty ? ExampleStatus.empty : ExampleStatus.loaded,
        data: data,
      )),
    );
  }
}
```

### Global Error Handling
```dart
// In your UseCase
class GetExampleUseCase {
  final ExampleRepository _repository;
  final RecordErrorUseCase _recordError;
  
  GetExampleUseCase(this._repository, this._recordError);
  
  Future<Either<Failure, List<Example>>> call(GetExampleParams params) async {
    try {
      return await _repository.getExamples(filter: params.filter);
    } catch (e, stackTrace) {
      // Record unexpected errors
      await _recordError(
        RecordErrorParams(
          error: e,
          stackTrace: stackTrace,
          context: 'GetExampleUseCase',
        ),
      );
      
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
```

## 🧩 Core Components System

### Available Components in `core/components/`

#### Atoms
## Text
- `HeadingText` - Customizable heading text component with multiple font sizes and styles
- `RegularText` - Regular text component with predefined styles
- `SubTitleText` - Subtitle text component with predefined styles
- `TitleText` - Title text component with predefined styles
- `SkeletonAnimation` - Animated skeleton loading component
- `Skeleton` - Static skeleton placeholder component

#### Molecules
## Button
- `ArrowButton` - Button with arrow icon for navigation
- `DropdownMenuButton` - Button that opens dropdown menu options
- `MiniElevatedButton` - Small elevated button for compact spaces
- `MiniOutlinedButton` - Small outlined button for secondary actions
- `MiniIconButton` - Small icon-only button for toolbar actions

## Input
- `DropdownInput` - Dropdown input field with selectable options
- `EditableTextInput` - Text input that toggles between display and edit modes
- `OtpTextInput` - OTP/PIN input field with individual digit boxes
- `PasswordInput` - Password input field with show/hide toggle
- `PhoneTextInput` - Phone number input with country code picker
- `RegularInput` - Standard text input field with validation
- `SearchTextInput` - Search input field with search icon and clear button
- `RadioCircle` - Radio button with circular selection indicator
- `ContentSheet` - Bottom sheet component with customizable content area and drag handle for modal presentations

#### Organisms
- `BlinkAnimation` - Animated blinking component for attention-grabbing UI elements
- `BottomSheetImagePicker` - Bottom sheet component for image selection with camera and gallery options
- `ButtonWidget` - Customizable button component with various styles and loading states
- `CardShadow` - Card component with shadow effects for elevated content display
- `CardTicket` - Ticket-style card component with decorative edges and content sections
- `TextCursor` - Animated text cursor component for typing effects and text input indicators
- `DottedBorder` - Container with customizable dotted border styling
- `EmptyWidget` - Empty state display component with icon, title, and description
- `LoadingComponent` - Loading indicator component with customizable spinner and text
- `MoreCardButton` - Expandable card button for "show more" functionality
- `SmartNetworkImage` - Network image component with caching, placeholder, and error handling
- `SwitchWidget` - Custom switch toggle component with smooth animations

## 📝 Best Practices

1. **Use Module System** - Register all dependencies and routes in module files
2. **Follow Clean Architecture** - Separate data, domain, and presentation layers
3. **Use BLoC for state management** - Keep business logic separate from UI
4. **Implement proper navigation** - Use status enum for navigation states
5. **Use FormZ for validation** - Leverage FormZ for form state management
6. **Handle errors properly** - Use Failure classes and RecordErrorUseCase
7. **Use repository pattern** - Abstract data sources with Either<Failure, Success>
8. **Register dependencies correctly** - Use GetIt in module inject method
9. **Use core components** - Don't recreate existing components
10. **Follow naming conventions** - Consistent naming across the project

## 🚀 Example: Creating a New Feature

When asked to create a new feature:

1. **Create the module structure**:
   ```
   features/products/
   ├── data/
   │   ├── models/
   │   ├── repositories/
   │   └── sources/
   ├── domain/
   │   ├── entities/
   │   ├── repositories/
   │   └── usecases/
   ├── presentation/
   │   ├── pages/
   │   ├── blocs/
   │   └── widgets/
   ├── module.dart
   └── products.dart
   ```

2. **Create module.dart** with dependency injection and routes
3. **Register module** in app/modules.dart
4. **Implement repository pattern** with proper error handling
5. **Create use cases** for business logic
6. **Build BLoC** with events and states
7. **Use FormZ** for form validation
8. **Handle navigation** with status enum
9. **Use core components** for UI
10. **Test your implementation**

Remember: Always check existing patterns in the repository before implementing new features. Consistency is key!