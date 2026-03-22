import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../domain/permission.dart' as domain;

final permissionRepositoryProvider = AsyncNotifierProvider.autoDispose
    .family<PermissionRepositoryNotifier, domain.Perm, Permission>(
      PermissionRepositoryNotifier.new,
    );

class PermissionRepositoryNotifier extends AsyncNotifier<domain.Perm> {
  PermissionRepositoryNotifier(this.permission);
  final Permission permission;

  @override
  Future<domain.Perm> build() async {
    final status = await permission.status;
    return domain.Perm(status: status);
  }

  Future<domain.Perm> request() async {
    final currentState = await future;
    final status = await permission.request();
    final newState = currentState.copyWith(status: status);
    state = AsyncData(newState);
    return newState;
  }
}

final permissionContactsProvider = permissionRepositoryProvider(
  Permission.contacts,
);
