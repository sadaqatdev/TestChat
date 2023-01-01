import 'package:flutter/material.dart';

class TextTile extends StatelessWidget {
  final double bubbleRadius;
  final bool isSender;
  final Color color;
  final String text;
  final bool tail;
  final bool stateTick;
  const TextTile({
    Key? key,
    required this.text,
    this.bubbleRadius = 12,
    this.isSender = true,
    this.stateTick = false,
    this.color = Colors.white70,
    this.tail = true,
  }) : super(key: key);

  ///chat bubble builder method
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        isSender
            ? const Expanded(
                child: SizedBox(
                  width: 5,
                ),
              )
            : Container(),
        Container(
          color: Colors.transparent,
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(bubbleRadius),
                  topRight: Radius.circular(bubbleRadius),
                  bottomLeft: Radius.circular(tail
                      ? isSender
                          ? bubbleRadius
                          : 0
                      : 12),
                  bottomRight: Radius.circular(tail
                      ? isSender
                          ? 0
                          : bubbleRadius
                      : 12),
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: stateTick
                        ? const EdgeInsets.fromLTRB(12, 6, 28, 6)
                        : const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 12),
                    child: Text(
                      text,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const Positioned(
                    bottom: 1,
                    right: 1,
                    child: Icon(
                      Icons.done_all,
                      size: 18,
                      color: Color(0xFF92DEDA),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
