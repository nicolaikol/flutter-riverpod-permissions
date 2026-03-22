import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class RetryErrorCard extends StatelessWidget {
  const RetryErrorCard({super.key, required this.onRetry, required this.title});
  final void Function()? onRetry;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ErrorCard(
      onTap: onRetry,
      title: title,
      trailing: IconButton(
        onPressed: onRetry,
        icon: Icon(Icons.refresh_rounded, size: 30),
      ),
    );
  }
}

enum ErrorCardEmphasis { high, subtle }

class ErrorCard extends StatelessWidget {
  const ErrorCard({
    super.key,
    this.onTap,
    required this.title,
    this.subtitle,
    this.trailing,
    this.actions,
    this.emphasis = ErrorCardEmphasis.high,
  });

  final void Function()? onTap;
  final String title;
  final Widget? subtitle;
  final Widget? trailing;
  final List<Widget>? actions;
  final ErrorCardEmphasis emphasis;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    Color foregroundColor = colorScheme.onError;
    Color backgroundColor = colorScheme.error;
    switch (emphasis) {
      case ErrorCardEmphasis.high:
        break;
      case ErrorCardEmphasis.subtle:
        foregroundColor = colorScheme.onErrorContainer;
        backgroundColor = colorScheme.errorContainer;
    }

    return Card.outlined(
      color: backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            iconColor: foregroundColor,
            textColor: foregroundColor,
            title: Text(title),
            subtitle: subtitle,
            leading: HugeIcon(icon: HugeIcons.strokeRoundedAlert02, size: 30),
            trailing: trailing,
            onTap: onTap,
          ),
          if (actions != null)
            Padding(
              padding: EdgeInsets.fromLTRB(18, 0, 10, 10),
              child: Row(
                children: [
                  Expanded(child: SizedBox()),
                  ...actions!,
                ],
              ),
            ),
        ],
      ),
    );
  }
}
