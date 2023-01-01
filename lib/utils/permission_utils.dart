import 'dart:io';

import 'package:chat_app/utils/logs.dart';
import 'package:chat_app/utils/route_utils.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../common/widgets/snak_bar_widget.dart';

class PermissionUtils {
  //

  static Future<bool> checkAudioPermission() async {
    var status = await Permission.audio.request();

    dp(msg: "Audio service status", arg: status);
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      showSnackBarMessage(
        msg: "Permission is denied",
      );
      return false;
    } else if (status.isLimited) {
      return true;
    } else if (status.isPermanentlyDenied) {
      //

      await showPermissionDialog();

      if (Platform.isIOS) {
        Navigator.pop(GlobalContext.context);
      }

      var status2 = await Permission.audio.request();
      return status2.isGranted;
    } else {
      return false;
    }
  }

  static Future<bool> checkCameraPermission() async {
    var status = await Permission.camera.request();

    dp(msg: "camera service status", arg: status);
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      showSnackBarMessage(
        msg: "Permission is denied",
      );
      return false;
    } else if (status.isLimited) {
      return true;
    } else if (status.isPermanentlyDenied) {
      //

      await showPermissionDialog();

      if (Platform.isIOS) {
        Navigator.pop(GlobalContext.context);
      }

      var status2 = await Permission.camera.request();
      return status2.isGranted;
    } else {
      return false;
    }
  }

  static Future<bool> checkMicPermission() async {
    //

    var status = await Permission.microphone.request();

    dp(msg: "camera service status", arg: status);
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      showSnackBarMessage(
        msg: "Permission is denied",
      );
      return false;
    } else if (status.isLimited) {
      return true;
    } else if (status.isPermanentlyDenied) {
      //

      await showPermissionDialog();

      if (Platform.isIOS) {
        Navigator.pop(GlobalContext.context);
      }

      var status2 = await Permission.microphone.request();
      return status2.isGranted;
    } else {
      return false;
    }
  }

  static Future<bool> checkStoragePermission() async {
    //

    var status = await Permission.storage.request();

    dp(msg: "camera service status", arg: status);
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      showSnackBarMessage(
        msg: "Permission is denied",
      );
      return false;
    } else if (status.isLimited) {
      return true;
    } else if (status.isPermanentlyDenied) {
      //

      await showPermissionDialog();

      if (Platform.isIOS) {
        Navigator.pop(GlobalContext.context);
      }

      var status2 = await Permission.storage.request();
      return status2.isGranted;
    } else {
      return false;
    }
  }
}

Future showPermissionDialog() async {
  await showDialog(
      context: GlobalContext.context,
      builder: (context) {
        return SimpleDialog(
          children: [
            Material(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "Please give location permission for app work properly",
                      style: TextStyle(fontSize: 12),
                      maxLines: 3,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () async {
                        await openAppSettings();
                      },
                      child: const Align(
                        //  alignment: Alignment.centerRight,
                        child: Text("Open App Setting"),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      });
}
