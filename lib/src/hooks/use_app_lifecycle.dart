import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Hook to handle app lifecycle events.
///
/// Provides callbacks for when the app starts (first build) and when it
/// resumes from being paused/inactive.
void useAppLifecycle({
  VoidCallback? onStart,
  VoidCallback? onResume,
  VoidCallback? onPause,
  VoidCallback? onInactive,
  VoidCallback? onDetached,
}) {
  final binding = WidgetsBinding.instance;

  // Track if this is the first build
  final isFirstBuild = useRef(true);

  // Call onStart on first build
  useEffect(() {
    if (isFirstBuild.value && onStart != null) {
      isFirstBuild.value = false;
      // Schedule for after the frame to ensure the widget tree is built
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onStart();
      });
    }
    return null;
  }, [onStart]);

  // Listen to app lifecycle changes
  useEffect(() {
    if (onResume == null &&
        onPause == null &&
        onInactive == null &&
        onDetached == null) {
      return null;
    }

    final observer = _AppLifecycleObserver(
      onResume: onResume,
      onPause: onPause,
      onInactive: onInactive,
      onDetached: onDetached,
    );

    binding.addObserver(observer);

    return () => binding.removeObserver(observer);
  }, [onResume, onPause, onInactive, onDetached]);
}

class _AppLifecycleObserver extends WidgetsBindingObserver {
  _AppLifecycleObserver({
    this.onResume,
    this.onPause,
    this.onInactive,
    this.onDetached,
  });

  final VoidCallback? onResume;
  final VoidCallback? onPause;
  final VoidCallback? onInactive;
  final VoidCallback? onDetached;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        onResume?.call();
        break;
      case AppLifecycleState.paused:
        onPause?.call();
        break;
      case AppLifecycleState.inactive:
        onInactive?.call();
        break;
      case AppLifecycleState.detached:
        onDetached?.call();
        break;
      case AppLifecycleState.hidden:
        // Hidden state introduced in newer Flutter versions
        break;
    }
  }
}
