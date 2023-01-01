import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  const ImageView({super.key, required this.imageUrl, required this.isLocal});
  final bool isLocal;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: isLocal
              ? Image.file(File(imageUrl))
              : CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const Center(
                    child: Text("Image not load"),
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                )),
    );
  }
}
