import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class AudioTile extends StatefulWidget {
  final double bubbleRadius;
  final bool isSender;
  final Color color;
  final bool tail;
  final AssetsAudioPlayer? assetsAudioPlayer;
  final String? path;
  final int duration;

  const AudioTile({
    Key? key,
    this.path,
    required this.duration,
    this.assetsAudioPlayer,
    this.bubbleRadius = 12,
    this.isSender = true,
    this.color = Colors.white70,
    this.tail = true,
  }) : super(key: key);

  @override
  State<AudioTile> createState() => _AudioTileState();
}

class _AudioTileState extends State<AudioTile> {
  //

  bool isPlaying = false;

  double? position = 0.0;

  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    assetsAudioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        widget.isSender
            ? const Expanded(
                child: SizedBox(
                  width: 5,
                ),
              )
            : Container(),
        Container(
          color: Colors.transparent,
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * .8, maxHeight: 70),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Container(
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(widget.bubbleRadius),
                  topRight: Radius.circular(widget.bubbleRadius),
                  bottomLeft: Radius.circular(widget.tail
                      ? widget.isSender
                          ? widget.bubbleRadius
                          : 0
                      : 12),
                  bottomRight: Radius.circular(widget.tail
                      ? widget.isSender
                          ? 0
                          : widget.bubbleRadius
                      : 12),
                ),
              ),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Card(
                          margin: const EdgeInsets.only(left: 12, right: 0),
                          shape: const CircleBorder(),
                          child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: isPlaying
                                  ? InkWell(
                                      onTap: () {
                                        play();
                                      },
                                      child: const Icon(
                                        Icons.pause,
                                        size: 30.0,
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        isPlaying
                                            ? assetsAudioPlayer.playOrPause()
                                            : play();
                                      },
                                      child: const Icon(
                                        Icons.play_arrow,
                                        size: 30.0,
                                      ),
                                    ))),
                      Expanded(
                        child: StreamBuilder<Duration?>(
                            stream: assetsAudioPlayer.currentPosition,
                            builder: (context, snapshot) {
                              return Slider(
                                min: 0.0,
                                max: widget.duration.toDouble(),
                                value: snapshot.data?.inSeconds.toDouble() ?? 0,
                                onChanged: onSeekChanged,
                              );
                            }),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 8,
                    right: 25,
                    child: Text(
                      audioTimer(widget.duration.toDouble(), position ?? 0.0),
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 12,
                      ),
                    ),
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
    );
  }

  play() async {
    if (mounted) {
      setState(() {
        isPlaying = true;
      });
    }

    await assetsAudioPlayer.open(
      Audio.file(widget.path!),
      seek: Duration(seconds: position!.toInt()),
    );

    assetsAudioPlayer.playlistFinished.listen((data) {
      if (data) {
        if (mounted) {
          setState(() {
            isPlaying = false;
          });
        }
      }
    });
  }

  String audioTimer(double duration, double position) {
    return '${(duration ~/ 60).toInt()}:${(duration % 60).toInt().toString().padLeft(2, '0')}/${position ~/ 60}:${(position % 60).toInt().toString().padLeft(2, '0')}';
  }

  void onSeekChanged(double value) {
    position = value;
    assetsAudioPlayer.seek(
      Duration(seconds: value.toInt()),
      force: true,
    );
    if (mounted) setState(() {});
  }
}
