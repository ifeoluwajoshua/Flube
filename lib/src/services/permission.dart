import 'package:flube/src/widgets/toast.dart';
import 'package:permission_handler/permission_handler.dart';

class StoragePermission {
  // Ask permission

  Future<bool> askPermissions() async {
    bool state;
    PermissionStatus permissionStatus = await _getStoragePermission();
    if (permissionStatus == PermissionStatus.granted) {
      print('Granted');
      state = true;
    } else {
      state = false;
      _handleInvalidPermissions(permissionStatus);
    }
    return state;
  }

// Get permission for Storage

  Future<PermissionStatus> _getStoragePermission() async {
    PermissionStatus permission = await Permission.storage.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.storage.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

//Handle invalid permisssion

  _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      showToast('Access to Storage Denied');
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      showToast('Access to Storage Permanetyl Denied');
    }
  }
}
