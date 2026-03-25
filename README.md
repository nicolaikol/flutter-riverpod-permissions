# riverpod_permissions

A UI wrapper around [permission_handler](https://pub.dev/packages/permission_handler) with Riverpod state management. Handles common patterns like re-checking permissions on app resume and **automatically detecting permanently denied permissions to redirect users to Settings**.

<p align="center">
  <img src="https://raw.githubusercontent.com/nicolaikol/flutter-riverpod-permissions/main/screenshots/splash_screen.png" alt="Permission Splash Screen" width="280" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://raw.githubusercontent.com/nicolaikol/flutter-riverpod-permissions/main/screenshots/permission_denied.png" alt="Permanently Denied — Open Settings" width="280" />
</p>

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
      detailsBuilder: (TextSpan permissionName) => <TextSpan>[
        TextSpan(text: 'How we use your '),
        permissionName,
        TextSpan(
          text:
              ' data - when you add a transaction with someone in your contacts, we only take the phone number which you have stored for that user and upload it to the server. Nothing else is taken from your ',
        ),
        permissionName,
        TextSpan(text: ', not even the name of the person. '),
      ],
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

### Permanently denied detection

When a user **permanently denies** a permission (or revokes it via system settings), the splash screen automatically detects this and transforms the UI:

- A **warning banner** appears explaining that the permission must be granted from Settings
- The action button changes from "Continue" to **"Open Settings"**, which deep-links directly into your app's system settings page

This is handled entirely by the package — **no extra code required**. The same `PermissionSplashScreen` widget adapts its UI based on the current permission state, including when the user returns from Settings via app resume detection.

## Additional information

- **Issues & contributions:** [GitHub Issues](https://github.com/nicolaikol/flutter-riverpod-permissions/issues)
- **License:** [Apache 2.0](LICENSE)
