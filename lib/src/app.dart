import 'package:chat_app/src/route.dart';
import 'package:chat_app/utils/route_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chatmain/providers/chat_provider.dart';

/// The Widget that configures your application.
class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatProvider(),
      child: MaterialApp(
        restorationScopeId: 'app',
        navigatorKey: GlobalContext.navigatorKey,
        supportedLocales: const [
          Locale('en', ''), // English, no country code
        ],
        theme: ThemeData.dark(),
        // darkTheme: ThemeData.dark(),
        // Define a function to handle named routes in order to support
        // Flutter web url navigation and deep linking.
        onGenerateRoute: (RouteSettings routeSettings) {
          return appRoute(routeSettings);
        },
      ),
    );
  }
}
