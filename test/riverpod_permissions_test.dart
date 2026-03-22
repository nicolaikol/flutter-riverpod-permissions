import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_permissions/riverpod_permissions.dart';

void main() {
  test('RiverpodPermissions can be initialized', () {
    RiverpodPermissions.initialize(const RiverpodPermissionsConfig());
    expect(RiverpodPermissions.config, isNotNull);
  });
}
