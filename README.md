# riverpod_permissions

A UI wrapper around [permission_handler](https://pub.dev/packages/permission_handler) with Riverpod state management. Handles common patterns like re-checking permissions on app resume and redirecting to Settings when permanently denied.

## Getting started

### 1. Install

```yaml
dependencies:
  riverpod_permissions: ^0.0.1
```

### 2. Platform setup

Follow the [permission_handler setup guide](https://pub.dev/packages/permission_handler#setup) for each platform you target (iOS `Info.plist`, Android `AndroidManifest.xml`, etc.).

### 3. Initialise

```dart
import 'package:riverpod_permissions/riverpod_permissions.dart';

void main() {
  RiverpodPermissions.initialize(
    RiverpodPermissionsConfig(
      brandingWidget: Image.asset('assets/logo.png'),
    ),
  );
  runApp(const ProviderScope(child: MyApp()));
}
```

## Features

### Riverpod provider

Listen to any permission's state with `permissionRepositoryProvider`:

```dart
final contactsPerm = ref.watch(permissionRepositoryProvider(Permission.contacts));

switch (contactsPerm) {
  case AsyncData(:final value):
    if (value.isAvailable) {
      // Permission granted — show feature
    }
  case AsyncError(:final error):
    // Handle error
  case _:
    // Loading
}
```

### Permission splash screen

Use convenience constructors for common permissions:

```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (_) => PermissionSplashScreen.contacts(
      onComplete: () => Navigator.of(context).pop(),
    ),
  ),
);
```

Or the general constructor for any permission:

```dart
PermissionSplashScreen(
  permission: Permission.microphone,
  permissionName: 'Microphone',
  onComplete: () => Navigator.of(context).pop(),
)
```

## Additional information

- **Issues & contributions:** [GitHub Issues](https://github.com/nicolaikol/flutter-riverpod-permissions/issues)
- **License:** [Apache 2.0](LICENSE)
