import 'package:flutter/material.dart';

import 'package:chat_app/src/chatmain/models/user_model.dart';

class ContactTile extends StatelessWidget {
  final ChatUser user;
  final Function(ChatUser) onTap;
  const ContactTile({
    Key? key,
    required this.onTap,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(user);
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage(user.imageURL),
                    maxRadius: 30,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            user.name,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            user.messageText,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              user.time,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
