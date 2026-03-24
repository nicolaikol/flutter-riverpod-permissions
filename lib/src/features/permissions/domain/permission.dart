import 'package:permission_handler/permission_handler.dart';

class Perm {
  const Perm({required this.status});

  final PermissionStatus status;

  // A word on: status.isDenied
  //  - It's possible that we status.isPermanentlyDenied, but we don't know for sure until we do a request();
  //  - Therefore needsOpenSettings can fail to identify the truth.
  bool get needsOpenSettings => status.isPermanentlyDenied || status.isLimited;
  bool get isAvailable => status.isGranted || status.isLimited;

  Perm copyWith({PermissionStatus? status}) {
    return Perm(status: status ?? this.status);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Perm &&
          runtimeType == other.runtimeType &&
          status == other.status;

  @override
  int get hashCode => status.hashCode;

  @override
  String toString() => 'Perm(status: $status)';
}
