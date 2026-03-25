import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../config.dart';
import '../../../components/error_cards.dart';
import '../../../components/riverpod_async_card.dart';
import '../../../hooks/use_app_lifecycle.dart';
import '../data/permission_repository.dart';
import '../domain/permission.dart' as domain;

String _permissionNameFromPermission(Permission permission) {
  final name = permission
      .toString() // e.g. "Permission.contacts"
      .split('.')
      .last;
  return name[0].toUpperCase() + name.substring(1);
}

class PermissionSplashScreen extends StatefulHookConsumerWidget {
  PermissionSplashScreen.camera({
    Key? key,
    VoidCallback? onComplete,
    List<TextSpan> Function(TextSpan permissionName)? detailsBuilder,
  }) // WARNING: DO NOT launch this unless you detect camera error because Android doesn't seem to need camera permission?
  : this(
         key: key,
         permission: Permission.camera,
         icon: HugeIcons.strokeRoundedCamera01,
         onComplete: onComplete,
         detailsBuilder: detailsBuilder,
       );

  PermissionSplashScreen.contacts({
    Key? key,
    VoidCallback? onComplete,
    List<TextSpan> Function(TextSpan permissionName)? detailsBuilder,
  }) : this(
         key: key,
         permission: Permission.contacts,
         icon: HugeIcons.strokeRoundedContact01,
         onComplete: onComplete,
         detailsBuilder: detailsBuilder,
       );

  PermissionSplashScreen({
    super.key,
    required this.permission,
    String? permissionName,
    this.detailsBuilder,
    this.icon,

    /// Called when the permission is granted (or upgraded from limited).
    /// If null, defaults to [Navigator.of(context).pop].
    this.onComplete,
  }) : permissionName =
           permissionName ?? _permissionNameFromPermission(permission);

  final Permission permission;
  final String permissionName;
  final List<TextSpan> Function(TextSpan permissionName)? detailsBuilder;
  final List<List<dynamic>>? icon;
  final VoidCallback? onComplete;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PermissionSplashScreenState();
}

class _PermissionSplashScreenState
    extends ConsumerState<PermissionSplashScreen> {
  // NON-STATE:
  PermissionStatus? _lastStatus;
  bool _isRequesting = false;
  bool _isAlreadyPopped = false;

  @override
  void initState() {
    super.initState();

    final subscription = ref.listenManual(
      permissionRepositoryProvider(widget.permission),
      _checkGranted,
    );
    final currentValue = subscription.read();
    _checkGranted(null, currentValue);
  }

  void _checkGranted(
    AsyncValue<domain.Perm>? prev,
    AsyncValue<domain.Perm> next,
  ) async {
    PermissionStatus? status = next.value?.status;
    if (status == null) {
      return;
    }

    if (status.isGranted ||
        (status.isLimited && _lastStatus != null && !_lastStatus!.isGranted)) {
      _doSuccess();
    }

    _lastStatus = status;
  }

  void _doSuccess() {
    if (mounted && !_isAlreadyPopped) {
      _isAlreadyPopped = true;
      final cb = widget.onComplete;
      if (cb != null) {
        cb();
      } else {
        Navigator.of(context).pop();
      }
    }
  }

  void _onResume() {
    ref.invalidate(permissionRepositoryProvider(widget.permission));
  }

  void _doRequest(domain.Perm permission) async {
    if (permission.needsOpenSettings) {
      if (!await openAppSettings()) {
        if (mounted) {
          RiverpodPermissions.config.showErrorHandler(
            context,
            'Failed to open Settings',
          );
        }
      }
      return;
    }

    setState(() {
      _isRequesting = true;
    });
    try {
      await ref
          .read(permissionRepositoryProvider(widget.permission).notifier)
          .request();
    } catch (e) {
      if (mounted) {
        RiverpodPermissions.config.showErrorHandler(
          context,
          'Something went wrong.',
        );
      }
    } finally {
      setState(() {
        _isRequesting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use the app lifecycle hook to handle resume events
    useAppLifecycle(onResume: _onResume);

    final colorScheme = Theme.of(context).colorScheme;

    List<Widget> columns = <Widget>[
      Expanded(child: SizedBox(height: 30.0)),
      if (RiverpodPermissions.config.brandingWidget != null)
        RiverpodPermissions.config.brandingWidget!,
      SizedBox(height: 30.0),
      RiverpodAsyncCard(
        provider: permissionRepositoryProvider(widget.permission),
        builder: (permission) {
          List<TextSpan> titlePrefix = [
            const TextSpan(
              text:
                  'In order to continue, we need to ask your permission for access to your ',
            ),
          ];
          String buttonText = permission.needsOpenSettings
              ? 'Open Settings'
              : 'Continue';
          String buttonTextInProgress = permission.needsOpenSettings
              ? 'Opening Settings...'
              : 'Continuing...';
          if (permission.status.isLimited) {
            titlePrefix = [
              TextSpan(text: 'You only provided '),
              TextSpan(
                text: 'Limited',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.error,
                ),
              ),
              TextSpan(text: ' access to your '),
            ];
            buttonText = 'Give more access';
          }

          return Column(
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.headlineSmall,
                  children: <TextSpan>[
                    ...titlePrefix,
                    TextSpan(
                      text: widget.permissionName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                    TextSpan(text: '.'),
                  ],
                ),
              ),
              if (permission.needsOpenSettings) ...[
                SizedBox(height: 30),
                ErrorCard(
                  emphasis: ErrorCardEmphasis.subtle,
                  title: 'You need to open Settings and give this access.',
                ),
              ],
              SizedBox(height: 30.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                    width: MediaQuery.of(context).size.width,
                  ),
                  child: FilledButton.icon(
                    onPressed: _isRequesting
                        ? null
                        : () => _doRequest(permission),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      textStyle: TextStyle(fontSize: 20.0),
                    ),
                    icon: permission.needsOpenSettings
                        ? HugeIcon(
                            icon: HugeIcons.strokeRoundedLinkForward,
                            size: 20,
                          )
                        : widget.icon == null
                        ? null
                        : HugeIcon(icon: widget.icon!, size: 20),
                    label: Text(
                      _isRequesting ? buttonTextInProgress : buttonText,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      SizedBox(height: 30.0),
      if (widget.detailsBuilder != null)
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            children: widget.detailsBuilder!(
              TextSpan(
                text: widget.permissionName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
      Expanded(child: SizedBox(height: 30.0)),
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: columns,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
