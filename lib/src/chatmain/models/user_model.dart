class ChatUser {
  String name;
  String messageText;
  String imageURL;
  String time;
  ChatUser(
      {required this.name,
      required this.messageText,
      required this.imageURL,
      required this.time});
}

List<ChatUser> chatUsers = [
  ChatUser(
      name: "Sadaqat Hussain",
      messageText: "Hi, how are you",
      imageURL: "assets/images/user1.png",
      time: "Now"),
  ChatUser(
      name: "YC Admin",
      messageText: "That's Great",
      imageURL: "assets/images/user2.png",
      time: "Yesterday"),
];
