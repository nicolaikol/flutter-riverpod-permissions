import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_permissions/riverpod_permissions.dart';

void main() {
  RiverpodPermissions.initialize(
    RiverpodPermissionsConfig(
      // Optional: display your app logo at the top of permission screens.
      // brandingWidget: Image.asset('assets/logo.png', height: 64),
    ),
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Permissions Example')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Navigate to a pre-built contacts permission screen.
            FilledButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PermissionSplashScreen.contacts(
                    onComplete: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
              child: const Text('Request Contacts Permission'),
            ),
            const SizedBox(height: 16),
            // Or use the general constructor for any permission.
            FilledButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PermissionSplashScreen(
                    permission: Permission.microphone,
                    permissionName: 'Microphone',
                    onComplete: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
              child: const Text('Request Microphone Permission'),
            ),
          ],
        ),
      ),
    );
  }
}
