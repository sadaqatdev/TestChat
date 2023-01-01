import 'package:chat_app/src/chatmain/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'chatmain/screens/contact_list_screen.dart';

MaterialPageRoute appRoute(routeSettings) {
  return MaterialPageRoute<void>(
    settings: routeSettings,
    builder: (BuildContext context) {
      switch (routeSettings.name) {
        case ContactListScreen.routeName:
          return const ContactListScreen();
        case ChatScreen.routeName:
          return ChatScreen();
        default:
          return const ContactListScreen();
      }
    },
  );
}
