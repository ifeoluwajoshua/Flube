import 'package:flube/src/services/permission.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final permissionProvider = StateNotifierProvider((ref) => StoragePermission(false));