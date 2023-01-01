import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chat_app/src/chatmain/models/message_model.dart';
import 'package:chat_app/src/chatmain/providers/chat_provider.dart';
import 'package:chat_app/src/chatmain/screens/audio_box.dart';
import 'package:chat_app/src/chatmain/screens/image_view.dart';
import 'package:chat_app/src/chatmain/screens/video_screen.dart';
import 'package:chat_app/src/chatmain/widgets/chat_bottom.dart';
import 'package:chat_app/src/chatmain/widgets/document_widget.dart';
import 'package:chat_app/utils/route_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:provider/provider.dart';

import '../widgets/audio_tile.dart';
import '../widgets/image_tile.dart';
import '../widgets/text_tile.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, this.name});

  static const routeName = "/ChatScreen";

  final String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(name ?? ''),
      ),
      body: Consumer<ChatProvider>(builder: (context, provider, child) {
        return SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: provider.chatList.length,
                    shrinkWrap: true,
                    reverse: true,
                    itemBuilder: ((context, index) {
                      int itemCount = provider.chatList.length;

                      int reversedIndex = itemCount - 1 - index;

                      return MessageTile(
                        key: Key(index.toString()),
                        messageModel: provider.chatList[reversedIndex],
                      );
                    })),
              ),
              provider.showDefaultChatBox
                  ? ChatBottom(
                      messageBarColor: const Color.fromARGB(255, 50, 44, 44),
                      onMicTap: () {
                        provider.toggleChatBox(false);
                      },
                      onSend: (text) {
                        provider.sendMessage(text);
                      },
                      actions: [
                        InkWell(
                          child: const Icon(
                            Icons.attach_file,
                            color: Colors.green,
                            size: 24,
                          ),
                          onTap: () {
                            provider.sendFile();
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: InkWell(
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.green,
                              size: 24,
                            ),
                            onTap: () {
                              provider.sendImage();
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: InkWell(
                            child: const Icon(
                              Icons.videocam,
                              color: Colors.green,
                              size: 24,
                            ),
                            onTap: () {
                              provider.sendVideo();
                            },
                          ),
                        ),
                      ],
                    )
                  : AudioBox(
                      audioRecorderInitCallBack: (audioRecorder, timer) {
                        //
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        provider.toggleChatBox(false);
                        //
                      },
                      audioSendTapCallBack: (audioPath, duration) {
                        //
                        provider.toggleChatBox(true);

                        provider.sendAudio(audioPath, duration);
                        //
                      },
                      onCancelTap: () {
                        //
                        provider.toggleChatBox(true);
                        //
                      },
                    )
            ],
          ),
        );
      }),
    );
  }
}

class MessageTile extends StatelessWidget {
  const MessageTile(
      {super.key, required this.messageModel, this.assetsAudioPlayer});

  final MessageModel messageModel;

  final AssetsAudioPlayer? assetsAudioPlayer;

  @override
  Widget build(BuildContext context) {
    switch (messageModel.messageType) {
      case MessageType.text:
        return TextTile(
          text: messageModel.messageContent!,
          isSender: messageModel.userType == UserType.sender,
          color: messageModel.userType == UserType.sender
              ? Colors.white
              : Colors.grey,
        );
      case MessageType.image:
        return ImageTile(
          url: messageModel.url!,
          onTap: () {
            SystemChannels.textInput.invokeMethod('TextInput.hide');

            toNext(
                context,
                ImageView(
                    imageUrl: messageModel.url!,
                    isLocal: messageModel.isLocal));
          },
          isLocal: messageModel.isLocal,
          isSender: messageModel.userType == UserType.sender,
          color: messageModel.userType == UserType.sender
              ? Colors.white
              : Colors.grey,
        );
      case MessageType.video:
        return ImageTile(
          onTap: () {
            SystemChannels.textInput.invokeMethod('TextInput.hide');

            toNext(
                context,
                VideoScreen(
                    url: messageModel.url!, isLocal: messageModel.isLocal));
          },
          url: messageModel.thumbnail!,
          isLocal: messageModel.isLocal,
          isVideo: true,
          isSender: messageModel.userType == UserType.sender,
          color: messageModel.userType == UserType.sender
              ? Colors.white
              : Colors.grey,
        );
      case MessageType.audio:
        return AudioTile(
          key: Key(messageModel.url.toString()),
          isSender: messageModel.userType == UserType.sender,
          color: messageModel.userType == UserType.sender
              ? Colors.white
              : Colors.grey,
          path: messageModel.url,
          duration: messageModel.audioDuration!,
        );
      case MessageType.document:
        return DocumentTile(
          onTap: () async {
            SystemChannels.textInput.invokeMethod('TextInput.hide');

            await OpenFile.open(messageModel.url);
          },
          isSender: messageModel.userType == UserType.sender,
          color: messageModel.userType == UserType.sender
              ? Colors.white
              : Colors.grey,
          fileName: messageModel.messageContent ?? '',
        );
    }
  }
}
