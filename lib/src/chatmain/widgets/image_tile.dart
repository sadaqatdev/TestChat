import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';

class ImageTile extends StatelessWidget {
  static const loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  final String url;
  final double bubbleRadius;
  final bool isSender;
  final Color color;
  final bool tail;
  final bool isLocal;
  final bool isVideo;
  final void Function()? onTap;

  const ImageTile({
    Key? key,
    required this.isLocal,
    required this.url,
    this.isVideo = false,
    this.bubbleRadius = 12,
    this.isSender = true,
    this.color = Colors.white70,
    this.tail = true,
    this.onTap,
  }) : super(key: key);

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
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * .5,
                maxHeight: MediaQuery.of(context).size.width * .38),
            child: InkWell(
                onTap: onTap,
                child: Stack(
                  children: [
                    Container(
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
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(bubbleRadius),
                          child: isLocal
                              ? Image.file(File(url),
                                  fit: BoxFit.cover, width: 225, height: 200)
                              : CachedNetworkImage(
                                  imageUrl: url,
                                  width: 225,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          isVideo ? Icons.videocam : Icons.image_rounded,
                          size: 35,
                        ),
                      ),
                    )
                  ],
                )),
          ),
        )
      ],
    );
  }
}
