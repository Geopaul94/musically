  import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestStoragePermission(BuildContext context) async {
    var status = await Permission.storage.status;
    await Permission.camera.request();

  await Permission.storage.request();

    if (status.isDenied) {
      // Request permission from the user
      status = await Permission.storage.request();
        await Permission.camera.request();

  await Permission.storage.request();
      // If permission is denied, show a message
      if (status.isDenied) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text(' give the permission')),
        // );
        return false;
      }
    }

    return status.isGranted;
  }
