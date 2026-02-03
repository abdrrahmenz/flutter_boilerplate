# shadcn_ui Migration Guide

## Overview
This document details the complete migration from custom Material 3 components to the shadcn_ui design system in the Flutter boilerplate project.

**Migration Date:** February 3, 2026  
**shadcn_ui Version:** 0.45.1  
**Status:** ✅ Complete

---

## What Changed

### 🎨 Design System
- **Typography:** Geist Sans font family (9 weights: 100-900) replacing Poppins
- **Color Scheme:** Material 3 ColorScheme with ShadSlateColorScheme (light/dark themes)
- **Component Library:** shadcn_ui components replacing custom implementations
- **Theme System:** ShadApp with AdaptiveTheme integration

### 📦 New Dependencies
```yaml
dependencies:
  shadcn_ui: ^0.45.1

fonts:
  - family: Geist
    fonts:
      - asset: assets/fonts/geist/Geist-Thin.ttf
        weight: 100
      - asset: assets/fonts/geist/Geist-ExtraLight.ttf
        weight: 200
      - asset: assets/fonts/geist/Geist-Light.ttf
        weight: 300
      - asset: assets/fonts/geist/Geist-Regular.ttf
        weight: 400
      - asset: assets/fonts/geist/Geist-Medium.ttf
        weight: 500
      - asset: assets/fonts/geist/Geist-SemiBold.ttf
        weight: 600
      - asset: assets/fonts/geist/Geist-Bold.ttf
        weight: 700
      - asset: assets/fonts/geist/Geist-ExtraBold.ttf
        weight: 800
      - asset: assets/fonts/geist/Geist-Black.ttf
        weight: 900
```

---

## Components Migration

### ❌ Deleted Components (12 files)

#### Text Components (4)
- `HeadingText` → Use `Text()` with `context.h1` - `context.h4`
- `RegularText` → Use `Text()` with `context.bodyLarge` - `context.bodySmall`
- `SubTitleText` → Use `Text()` with `context.label`
- `TitleText` → Use `Text()` with `context.h3`

#### Button Components (7)
- `MiniElevatedButton` → Use `ShadButton(size: ShadButtonSize.sm)`
- `MiniOutlinedButton` → Use `ShadButton.outline(size: ShadButtonSize.sm)`
- `MiniIconButton` → Use `ShadButton` with `icon` or `leading` parameter
- `ArrowButton` → Deleted (no usages)
- `GradientButton` → Deleted (no usages)
- `DropdownMenuButton` → Deleted (no usages)
- `ButtonWidget` → Use `ShadButton` variants

#### Switch Component (1)
- `SwitchWidget` → Use `ShadSwitch` from shadcn_ui

### ✅ New Components (6 files)

#### Helper Files
**`lib/core/helpers/text_helpers.dart`**
```dart
extension TextStyleHelpers on BuildContext {
  TextStyle? get h1 => theme.textTheme.displayLarge;
  TextStyle? get h2 => theme.textTheme.displayMedium;
  TextStyle? get h3 => theme.textTheme.displaySmall;
  TextStyle? get h4 => theme.textTheme.headlineMedium;
  TextStyle? get bodyLarge => theme.textTheme.bodyLarge;
  TextStyle? get body => theme.textTheme.bodyMedium;
  TextStyle? get bodySmall => theme.textTheme.bodySmall;
  TextStyle? get muted => theme.textTheme.bodySmall?.copyWith(
    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
  );
  TextStyle? get label => theme.textTheme.labelLarge;
  TextStyle? get caption => theme.textTheme.labelSmall;
}
```

**`lib/core/helpers/formz_error_messages.dart`**
- FormZ error message localization maps for all input types
- Centralized error message management

**`lib/core/helpers/formz_shad_input.dart`**
- FormZ-aware ShadInput wrapper functions
- Type-safe input components with validation

#### Input Components
**`lib/core/components/molecule/input/shad_text_input.dart`**
```dart
ShadTextInput(
  label: 'Email',
  controller: emailController,
  errorText: state.email.errorMessage,
  keyboardType: TextInputType.emailAddress,
)
```

**`lib/core/components/molecule/input/shad_password_input.dart`**
```dart
ShadPasswordInput(
  label: 'Password',
  controller: passwordController,
  errorText: state.password.errorMessage,
)
```

**`lib/core/components/molecule/input/shad_search_input.dart`**
```dart
ShadSearchInput(
  placeholder: 'Search...',
  onChanged: (value) => bloc.add(SearchEvent(query: value)),
)
```

### 🔄 Updated Components (22 preserved)

#### Atoms (3)
- ✅ **Skeleton** - Updated with AppColors shimmer (getShimmerBaseColor, getShimmerHighlightColor)
- ✅ **SkeletonAnimation** - Updated with AppColors shimmer
- 📂 **text/text.dart** - Empty barrel file

#### Molecules (7 + 4 base inputs)
- ✅ **RadioCircle** - Updated to use `colorScheme.primary` and `colorScheme.outline`
- ✅ **InputLabel** - Updated to use `context.label` and `colorScheme.primary`
- ✅ **ContentSheet** - Updated drag handle to use `colorScheme.outline.withValues(alpha: 0.3)`
- 🔄 **DismissibleKeyboard** - Preserved as-is
- 🔄 **FrostyGlassCard** - Preserved as-is
- 🔄 **DropdownInput** - Preserved (uses RegularInput base)
- 🔄 **EditableTextInput** - Preserved (uses RegularInput base)
- 🔄 **OtpTextInput** - Preserved (custom PIN input)
- 🔄 **PhoneInput** - Preserved (uses RegularInput + SearchTextInput base)
- 📌 **RegularInput** - Base component for specialized inputs
- 📌 **PasswordInput** - Base component for specialized inputs
- 📌 **SearchTextInput** - Base component for PhoneInput

#### Organisms (11)
- ✅ **CardShadow** - Updated to use `colorScheme.surface`, `colorScheme.shadow`, and `Dimens.radiusLg`
- 🔄 **EmptyWidget** - Uses context styles (already compatible)
- 🔄 **LoadingComponent** - Uses context styles (already compatible)
- 🔄 **BlinkAnimation** - Preserved as-is
- 🔄 **BottomSheetImagePicker** - Preserved as-is
- 🔄 **CardTicket** - Preserved as-is
- 🔄 **ChipWidget** - Preserved as-is (580 lines, complex component)
- 🔄 **DottedBorder** - Preserved as-is
- 🔄 **MoreCard** - Preserved as-is
- 🔄 **SmartNetworkImage** - Preserved as-is
- 🔄 **DashPainter** - Preserved as-is

---

## Usage Guide

### Text Styling
**Before:**
```dart
HeadingText('Welcome', size: HeadingSize.h1)
RegularText('Description')
SubTitleText('Subtitle')
TitleText('Title')
```

**After:**
```dart
Text('Welcome', style: context.h1)
Text('Description', style: context.body)
Text('Subtitle', style: context.label)
Text('Title', style: context.h3)
```

### Buttons
**Before:**
```dart
ElevatedButton(
  onPressed: () {},
  child: Text('Submit'),
)

OutlinedButton(
  onPressed: () {},
  child: Text('Cancel'),
)

TextButton(
  onPressed: () {},
  child: Text('Skip'),
)

MiniElevatedButton(
  onPressed: () {},
  child: Icon(Icons.add),
)
```

**After:**
```dart
ShadButton(
  onPressed: () {},
  child: Text('Submit'),
)

ShadButton.outline(
  onPressed: () {},
  child: Text('Cancel'),
)

ShadButton.ghost(
  onPressed: () {},
  child: Text('Skip'),
)

ShadButton(
  size: ShadButtonSize.sm,
  onPressed: () {},
  icon: Icon(Icons.add),
)
```

**Button Variants:**
- `ShadButton()` - Primary filled button
- `ShadButton.outline()` - Outlined button
- `ShadButton.ghost()` - Subtle text button
- `ShadButton.secondary()` - Secondary variant
- `ShadButton.destructive()` - Destructive actions
- `ShadButton.link()` - Link-style button

**Button Sizes:**
- `ShadButtonSize.sm` - Small (32px height)
- `ShadButtonSize.regular` - Regular (40px height, default)
- `ShadButtonSize.lg` - Large (48px height)

### Input Fields
**Before:**
```dart
CustomTextField(
  label: 'Email',
  controller: controller,
  errorText: error,
)

PasswordInput(
  label: 'Password',
  controller: controller,
)

SearchTextInput(
  hintText: 'Search...',
  onChanged: onChanged,
)
```

**After:**
```dart
ShadTextInput(
  label: 'Email',
  controller: controller,
  errorText: error,
  keyboardType: TextInputType.emailAddress,
)

ShadPasswordInput(
  label: 'Password',
  controller: controller,
  errorText: error,
)

ShadSearchInput(
  placeholder: 'Search...',
  onChanged: onChanged,
)
```

### FormZ Integration
```dart
// Using FormZ with shadcn inputs
buildShadTextInput(
  context: context,
  label: 'Email',
  formzInput: state.email,
  onChanged: (value) => bloc.add(EmailChanged(value)),
)

buildShadPasswordInput(
  context: context,
  label: 'Password',
  formzInput: state.password,
  onChanged: (value) => bloc.add(PasswordChanged(value)),
)
```

### Switch Component
**Before:**
```dart
SwitchWidget(
  isActive: isEnabled,
  onChanged: (value) => setState(() => isEnabled = value),
)
```

**After:**
```dart
ShadSwitch(
  value: isEnabled,
  onChanged: (value) => setState(() => isEnabled = value),
)
```

---

## Design Tokens

### Colors (AppColors extensions)
```dart
// Shimmer colors for skeleton loading
AppColors.getShimmerBaseColor(context)
AppColors.getShimmerHighlightColor(context)

// ColorScheme access
context.theme.colorScheme.primary
context.theme.colorScheme.surface
context.theme.colorScheme.outline
context.theme.colorScheme.shadow
```

### Border Radius (Dimens extensions)
```dart
Dimens.radiusSm   // 4.0
Dimens.radiusMd   // 8.0
Dimens.radiusLg   // 12.0
Dimens.radiusXl   // 16.0
Dimens.radius2xl  // 20.0
Dimens.radius3xl  // 24.0
```

---

## Theme Configuration

### App Setup
```dart
// lib/app/app.dart
return ShadApp.materialRouter(
  routerConfig: _appRouter.config,
  themeMode: themeNotifier.value,
  theme: ShadThemeData(
    brightness: Brightness.light,
    colorScheme: ShadSlateColorScheme.light(),
  ),
  darkTheme: ShadThemeData(
    brightness: Brightness.dark,
    colorScheme: ShadSlateColorScheme.dark(),
  ),
  // ... other configs
);
```

---

## Migration Checklist

- [x] Install shadcn_ui package (v0.45.1)
- [x] Configure Geist Sans fonts (9 weights)
- [x] Extend AppColors with shadcn color schemes
- [x] Extend Dimens with radius scale
- [x] Create text style helpers
- [x] Create FormZ helper utilities
- [x] Delete old text components (4 files)
- [x] Delete old button components (7 files)
- [x] Delete SwitchWidget
- [x] Create shadcn input components (3 files)
- [x] Update ~50 files with new components
- [x] Update preserved components with shadcn theming
- [x] Verify with `flutter analyze` (No issues found!)

---

## Files Modified

### Created (6 files)
- `lib/core/helpers/text_helpers.dart`
- `lib/core/helpers/formz_error_messages.dart`
- `lib/core/helpers/formz_shad_input.dart`
- `lib/core/components/molecule/input/shad_text_input.dart`
- `lib/core/components/molecule/input/shad_password_input.dart`
- `lib/core/components/molecule/input/shad_search_input.dart`

### Deleted (12 files)
- `lib/core/components/atom/text/heading_text.dart`
- `lib/core/components/atom/text/regular_text.dart`
- `lib/core/components/atom/text/subtitle_text.dart`
- `lib/core/components/atom/text/title_text.dart`
- `lib/core/components/molecule/button/mini_elevated.dart`
- `lib/core/components/molecule/button/mini_outlined.dart`
- `lib/core/components/molecule/button/mini_icon_button.dart`
- `lib/core/components/molecule/button/arrow_button.dart`
- `lib/core/components/molecule/button/gradient_button.dart`
- `lib/core/components/molecule/button/dropdown_menu_button.dart`
- `lib/core/components/organism/button_wiget.dart`
- `lib/core/components/organism/switch_widget.dart`

### Updated (50+ files)
- Auth module: login, register pages
- Settings module: edit profile, preferences
- Core components: RadioCircle, InputLabel, ContentSheet, CardShadow
- Skeleton components: skeleton.dart, skeleton_animation.dart
- All text component usages (~40 files)
- Design tokens: colors.dart, dimens.dart
- Theme configuration: app.dart

---

## Best Practices

### 1. Use Context Style Helpers
Always use `context.h1` - `context.h4`, `context.body`, `context.label`, etc. for consistent typography.

### 2. Use ColorScheme
Access colors through `context.theme.colorScheme` for proper theme support.

### 3. Use ShadButton Variants
Choose the appropriate variant based on button hierarchy:
- Primary actions → `ShadButton()`
- Secondary actions → `ShadButton.outline()`
- Tertiary actions → `ShadButton.ghost()`
- Destructive actions → `ShadButton.destructive()`

### 4. FormZ + shadcn Integration
Use helper functions from `formz_shad_input.dart` for type-safe validated inputs.

### 5. Preserve Specialized Components
Keep custom components that provide unique functionality (PhoneInput, OtpTextInput, DropdownInput, etc.).

---

## Verification

Run the following commands to verify the migration:

```bash
# Install dependencies
flutter pub get

# Run analyzer
flutter analyze --no-fatal-infos

# Expected output: "No issues found!"
```

---

## Next Steps

### Recommended Enhancements
1. **Add ShadSelect** - Replace DropdownInput with ShadSelect for better consistency
2. **Add ShadRadio** - Replace RadioCircle with ShadRadio
3. **Add ShadCheckbox** - For form checkboxes
4. **Add ShadDialog** - For modal dialogs
5. **Add ShadToast** - For notifications
6. **Add ShadCard** - Replace CardShadow with ShadCard

### Optional Migrations
- Consider migrating ChipWidget to use shadcn styling
- Review CardTicket for shadcn theming
- Update FrostyGlassCard with shadcn colors

---

## Resources

- **shadcn_ui Pub:** https://pub.dev/packages/shadcn_ui
- **shadcn/ui Docs:** https://ui.shadcn.com/
- **Geist Font:** https://vercel.com/font
- **Material 3:** https://m3.material.io/

---

**Migration completed successfully! 🎉**
