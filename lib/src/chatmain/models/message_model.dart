enum MessageType { text, image, video, audio, document }

enum UserType { sender, receiver }

class MessageModel {
  final String? messageContent;
  final MessageType messageType;
  final UserType userType;
  final String receiverName;
  final String? url;
  final String? thumbnail;
  final bool isLocal;
  final int? audioDuration;

  MessageModel(
      {required this.messageContent,
      this.thumbnail,
      required this.messageType,
      required this.userType,
      required this.receiverName,
      this.audioDuration,
      this.url,
      required this.isLocal});

  // ChatMessage({
  //   required this.messageContent,
  //   required this.messageType,
  //   required this.userType,
  // });
}
