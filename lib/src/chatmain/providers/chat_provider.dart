import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chat_app/common/methods/common_methods.dart';
import 'package:chat_app/common/widgets/dislog_widget.dart';
import 'package:chat_app/common/widgets/snak_bar_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../models/message_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ChatProvider extends ChangeNotifier {
  bool showDefaultChatBox = true;

  List<MessageModel> chatList = [];

  toggleChatBox(togle) {
    showDefaultChatBox = togle;
    notifyListeners();
  }

  sendAudio(String path, int duration) {
    chatList.add(MessageModel(
        messageContent: "Hi",
        messageType: MessageType.audio,
        receiverName: "Xyz",
        isLocal: true,
        url: path,
        audioDuration: duration,
        userType: UserType.sender));

    notifyListeners();
  }

  void sendMessage(String text) {
    chatList.add(MessageModel(
        messageContent: text,
        messageType: MessageType.text,
        receiverName: "Xyz",
        isLocal: false,
        userType: UserType.sender));

    notifyListeners();
  }

  Future<void> sendFile() async {
    //
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      var filename = basename(file.path);
      chatList.add(MessageModel(
          messageContent: '$filename ${getFileExtension(filename)}',
          messageType: MessageType.document,
          receiverName: "Xyz",
          isLocal: true,
          url: file.path,
          userType: UserType.sender));

      notifyListeners();
    } else {
      showSnackBarMessage(msg: "File not pick");
    }
  }

  String getFileExtension(String fileName) {
    return ".${fileName.split('.').last}";
  }

  void sendImage() async {
    showFileOPtion((imageSource) async {
      //

      var path = await CommonMethods.pickImage(imageSource);

      if (path != null) {
        chatList.add(MessageModel(
            messageContent: path,
            messageType: MessageType.image,
            receiverName: "Xyz",
            isLocal: true,
            url: path,
            userType: UserType.sender));

        notifyListeners();
      } else {
        showSnackBarMessage(msg: "Image not pick");
      }
    });
  }

  void sendVideo() async {
    showFileOPtion((imageSource) async {
      //

      var path = await CommonMethods.pickVideo(imageSource);

      if (path != null) {
        var thumbPath = await VideoThumbnail.thumbnailFile(
            video: path,
            thumbnailPath: (await getApplicationDocumentsDirectory()).path,
            imageFormat: ImageFormat.PNG,
            maxWidth: 200,
            maxHeight:
                215, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
            timeMs: 500,
            quality: 100);

        chatList.add(MessageModel(
            messageContent: path,
            thumbnail: thumbPath,
            messageType: MessageType.video,
            receiverName: "Xyz",
            isLocal: true,
            url: path,
            userType: UserType.sender));

        notifyListeners();
      } else {
        showSnackBarMessage(msg: "Video not pick");
      }
    });
  }
}
