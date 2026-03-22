import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permission.freezed.dart';

@freezed
abstract class Perm with _$Perm {
  const Perm._();
  const factory Perm({required PermissionStatus status}) = _Perm;

  // A word on: status.isDenied
  //  - It's possible that we status.isPermanentlyDenied, but we don't know for sure until we do a request();
  //  - Therefore needsOpenSettings can fail to identify the truth.
  bool get needsOpenSettings => status.isPermanentlyDenied || status.isLimited;
  bool get isAvailable => status.isGranted || status.isLimited;
}
