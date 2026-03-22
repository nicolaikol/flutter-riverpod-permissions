import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class RiverpodPermissionsConfig {
  const RiverpodPermissionsConfig({
    this.brandingWidget,
    this.showErrorHandler = defaultShowErrorHandler,
  });

  /// Widget shown at the top of permission screens (e.g. app logo).
  /// If null, no branding is displayed.
  final Widget? brandingWidget;

  final void Function(BuildContext context, Object? error) showErrorHandler;
}

class RiverpodPermissions {
  RiverpodPermissions._();

  static RiverpodPermissionsConfig? _config;

  static RiverpodPermissionsConfig get config {
    assert(
      _config != null,
      'RiverpodPermissions.initialize() must be called before accessing config.',
    );
    return _config!;
  }

  static void initialize(RiverpodPermissionsConfig config) {
    _config = config;
  }
}

void defaultShowErrorHandler(BuildContext context, Object? error) {
  String title;
  String? details;

  if (error is String) {
    title = error;
  } else if (error is Exception) {
    details = error.toString();
    title = 'Something went wrong.';
  } else {
    title = 'Something went wrong.';
  }

  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  Color foregroundColor = colorScheme.onError;
  Color backgroundColor = colorScheme.error;
  final messenger = ScaffoldMessenger.of(context);
  messenger.clearSnackBars();
  messenger.showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      content: ListTile(
        contentPadding: EdgeInsets.zero,
        iconColor: foregroundColor,
        textColor: foregroundColor,
        title: Text(title),
        subtitle: details != null ? Text(details) : null,
        subtitleTextStyle: theme.textTheme.bodySmall!.copyWith(
          color: foregroundColor,
        ),
        leading: HugeIcon(icon: HugeIcons.strokeRoundedAlert02, size: 30),
      ),
    ),
  );
}
