import 'package:better_video_player/better_video_player.dart';

import 'package:flutter/material.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({required this.url, required this.isLocal, super.key});

  final String url;
  final bool isLocal;

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  var betterController = BetterVideoPlayerController();

  BetterVideoPlayerDataSource? dataSource;

  @override
  void initState() {
    dataSource = BetterVideoPlayerDataSource(
      widget.isLocal
          ? BetterVideoPlayerDataSourceType.file
          : BetterVideoPlayerDataSourceType.network,
      widget.url,
    );
    super.initState();
  }

  @override
  void dispose() {
    betterController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16.0 / 9.0,
      child: BetterVideoPlayer(
        controller: betterController,
        dataSource: dataSource,
        configuration: const BetterVideoPlayerConfiguration(
          autoPlay: true,
          placeholder: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
