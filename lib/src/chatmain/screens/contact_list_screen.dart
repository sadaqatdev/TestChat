import 'package:chat_app/src/chatmain/models/user_model.dart';
import 'package:chat_app/src/chatmain/screens/chat_screen.dart';
import 'package:chat_app/src/chatmain/widgets/search_widget.dart';
import 'package:chat_app/utils/route_utils.dart';
import 'package:flutter/material.dart';

import '../widgets/contact_tile.dart';

class ContactListScreen extends StatelessWidget {
  const ContactListScreen({super.key});

  static const String routeName = "/ContactListScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Contact List"),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          const Expanded(flex: 10, child: SearchWidget()),
          Expanded(
            flex: 90,
            child: ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16, left: 12, right: 12),
              itemBuilder: (context, index) {
                return ContactTile(
                  user: chatUsers[index],
                  onTap: (user) {
                    toNext(
                        context,
                        ChatScreen(
                          name: chatUsers[index].name,
                        ));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
