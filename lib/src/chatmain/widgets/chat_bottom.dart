import 'package:flutter/material.dart';

class ChatBottom extends StatelessWidget {
  final bool replying;
  final String replyingTo;
  final List<Widget> actions;
  final TextEditingController _textController = TextEditingController();
  final Color replyWidgetColor;
  final Color replyIconColor;
  final Color replyCloseColor;
  final Color messageBarColor;
  final Color sendButtonColor;
  final void Function(String)? onTextChanged;
  final void Function(String)? onSend;
  final void Function() onMicTap;

  ChatBottom({
    super.key,
    this.replying = false,
    this.replyingTo = "",
    this.actions = const [],
    this.replyWidgetColor = const Color(0xffF4F4F5),
    this.replyIconColor = Colors.blue,
    this.replyCloseColor = Colors.black12,
    this.messageBarColor = const Color(0xffF4F4F5),
    this.sendButtonColor = Colors.blue,
    this.onTextChanged,
    this.onSend,
    required this.onMicTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            replying
                ? Container(
                    color: replyWidgetColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.reply,
                          color: replyIconColor,
                          size: 24,
                        ),
                        Expanded(
                          child: Container(
                            child: Text(
                              'Re : ' + replyingTo,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: onMicTap,
                          child: Icon(
                            Icons.close,
                            color: replyCloseColor,
                            size: 24,
                          ),
                        ),
                      ],
                    ))
                : Container(),
            replying
                ? Container(
                    height: 1,
                    color: Colors.grey.shade300,
                  )
                : Container(),
            Container(
              color: messageBarColor,
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: Row(
                children: <Widget>[
                  ...actions,
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
                      minLines: 1,
                      maxLines: 3,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      onChanged: onTextChanged,
                      decoration: InputDecoration(
                        hintText: "Type your message here",
                        hintMaxLines: 1,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 10),
                        hintStyle:
                            const TextStyle(fontSize: 16, color: Colors.black),
                        fillColor: Colors.grey,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 0.2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Colors.black26,
                            width: 0.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: InkWell(
                      child: Icon(
                        Icons.send,
                        color: sendButtonColor,
                        size: 24,
                      ),
                      onTap: () {
                        if (_textController.text.trim() != '') {
                          if (onSend != null) {
                            onSend!(_textController.text.trim());
                          }
                          _textController.text = '';
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: InkWell(
                      child: Icon(
                        Icons.mic,
                        color: sendButtonColor,
                        size: 24,
                      ),
                      onTap: () {
                        onMicTap();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
