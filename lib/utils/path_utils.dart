import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'package:chat_app/utils/logs.dart';

Future<String?> pathToApplicationDirectory() async {
  String customPath = '/weAlwaysChat';
  try {
    Directory appDocDirectory;

    if (Platform.isIOS) {
      appDocDirectory = await getApplicationDocumentsDirectory();
    } else {
      appDocDirectory = (await getExternalStorageDirectory())!;
    }

    // can add extension like ".mp4" ".wav" ".m4a" ".aac"
    customPath = appDocDirectory.path +
        customPath +
        DateTime.now().millisecondsSinceEpoch.toString();
    dp(msg: "Path", arg: customPath);
    return customPath;
  } catch (e, s) {
    ep(e, s);
    return null;
  }
}
