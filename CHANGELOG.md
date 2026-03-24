## 0.0.1

* Initial release.
* `PermissionSplashScreen` widget with named constructors for camera and contacts.
* `PermissionRepositoryNotifier` — Riverpod `AsyncNotifier` for checking and requesting permissions.
* `Perm` domain model wrapping `PermissionStatus`.
* `RiverpodPermissionsConfig` for global branding and error handling.
* Lifecycle-aware permission refresh via `useAppLifecycle` hook.
