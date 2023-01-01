import 'package:flutter/material.dart';

class DocumentTile extends StatelessWidget {
  final void Function() onTap;

  final bool isLoading;
  final double bubbleRadius;
  final bool isSender;
  final Color color;
  final bool tail;
  final String fileName;

  const DocumentTile({
    Key? key,
    required this.onTap,
    this.isLoading = true,
    this.bubbleRadius = 12,
    this.isSender = true,
    this.color = Colors.white70,
    this.tail = true,
    required this.fileName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
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
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * .6,
                maxHeight: 60),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
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
                  children: [
                    Row(
                      children: [
                        const Card(
                            margin: EdgeInsets.all(8),
                            shape: CircleBorder(),
                            child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.attach_file,
                                ))),
                        Expanded(
                          child: Text(fileName,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 11,
                              )),
                        ),
                      ],
                    ),
                    const Positioned(
                      bottom: 4,
                      right: 6,
                      child: Icon(
                        Icons.done_all,
                        size: 18,
                        color: Color(0xFF92DEDA),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String audioTimer(double duration, double position) {
    return '${(duration ~/ 60).toInt()}:${(duration % 60).toInt().toString().padLeft(2, '0')}/${position ~/ 60}:${(position % 60).toInt().toString().padLeft(2, '0')}';
  }
}
