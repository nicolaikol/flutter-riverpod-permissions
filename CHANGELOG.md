## 0.0.4

* Restore `Perm.isLimited` convenience getter.

## 0.0.3

* Pass `detailsBuilder` through convenience constructors (`PermissionSplashScreen.contacts()`, etc.).
* Enhanced README with screenshots and documentation for permanently denied detection.

## 0.0.2

* Tightened dependency lower bounds for pub.dev downgrade analysis compatibility.

## 0.0.1

* Initial release.
* `PermissionSplashScreen` widget with named constructors for camera and contacts.
* `PermissionRepositoryNotifier` — Riverpod `AsyncNotifier` for checking and requesting permissions.
* `Perm` domain model wrapping `PermissionStatus`.
* `RiverpodPermissionsConfig` for global branding and error handling.
* Lifecycle-aware permission refresh via `useAppLifecycle` hook.
