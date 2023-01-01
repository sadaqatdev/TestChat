import 'dart:async';
import 'dart:io';

import 'package:chat_app/common/widgets/snak_bar_widget.dart';
import 'package:chat_app/utils/logs.dart';
import 'package:chat_app/utils/path_utils.dart';
import 'package:chat_app/utils/permission_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_audio_recorder2/flutter_audio_recorder2.dart';

class AudioBox extends StatefulWidget {
  const AudioBox(
      {super.key,
      required this.audioRecorderInitCallBack,
      required this.audioSendTapCallBack,
      required this.onCancelTap});

  final VoidCallback onCancelTap;
  final Function(String audioPath, int suration) audioSendTapCallBack;
  final Function(dynamic audioRecorder, Timer timer) audioRecorderInitCallBack;

  @override
  State<AudioBox> createState() => _AudioBoxState();
}

class _AudioBoxState extends State<AudioBox> {
  //

  FlutterAudioRecorder2? _recorder;

  Recording? _current;

  RecordingStatus _currentStatus = RecordingStatus.Unset;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    initAudio();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 8,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    //onCancel Tap
                    cancelTap();
                  },
                  child: Icon(Icons.close),
                ),
                const Spacer(
                  flex: 3,
                ),
                //Here we add graph of audio recording
                Expanded(
                  flex: 92,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.mic, color: Colors.lightGreen),
                      ),
                      Flexible(
                          child: Text(
                        _current?.duration?.toString().split('.').first ?? '',
                        style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ))
                    ],
                  ),
                ),

                const Spacer(
                  flex: 5,
                ),
              ],
            ),
          ),
        ),
        //Send Buttpm For Audio is here

        InkWell(
          onTap: () {
            //Stopping Record on send
            stop();
          },
          child: Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: const UnconstrainedBox(
              //Togling b/w send and cam icon
              child: Icon(Icons.send),
            ),
          ),
        )
      ],
    );
  }

  initAudio() async {
    var storageStatus = await PermissionUtils.checkStoragePermission();
    var micStatus = await PermissionUtils.checkMicPermission();

    if (storageStatus && micStatus) {
      String? customPath = await pathToApplicationDirectory();

      // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.
      if (customPath == null) {
        showSnackBarMessage(msg: "Can not access path, try again");
        return;
      }
      _recorder =
          FlutterAudioRecorder2(customPath, audioFormat: AudioFormat.WAV);

      await _recorder?.initialized;
      // after initialization
      var current = await _recorder?.current(channel: 0);

      dp(msg: "Time", arg: current);
      // should be "Initialized", if all working fine

      setState(() {
        _current = current;
        _currentStatus = current!.status!;
      });
      //Staritng Recording Here

      _start();
    } else {
      showSnackBarMessage(msg: "Please give permission for app to work");
      widget.onCancelTap();
    }
  }

  _start() async {
    try {
      await _recorder?.start();

      var recording = await _recorder?.current(channel: 0);

      setState(() {
        _current = recording;
      });

      const tick = Duration(milliseconds: 50);

      timer = Timer.periodic(tick, (Timer t) async {
        if (_currentStatus == RecordingStatus.Stopped) {
          t.cancel();
        }

        var current = await _recorder?.current(channel: 0);

        if (this.mounted) {
          setState(() {
            _current = current;
            _currentStatus = _current!.status!;
          });
        }
      });

      widget.audioRecorderInitCallBack(_recorder, timer!);
    } catch (e, s) {
      ep(e, s);
      dp(msg: "Error in record", arg: e);
    }
  }

  stop() async {
    var result = await _recorder?.stop();

    if (result?.path == null) {
      return;
    }

    setState(() {
      _current = result;
      _currentStatus = _current!.status!;
    });
    await Future.delayed(const Duration(milliseconds: 50));
    widget.audioSendTapCallBack(result!.path!, result.duration!.inSeconds);
  }

  cancelTap() async {
    var result = await _recorder?.stop();

    dp(msg: "Audio stop");

    if (result != null && File(result.path ?? '').existsSync()) {
      File(result.path!).deleteSync(recursive: true);
    }
    setState(() {
      _current = result;
      _currentStatus = _current!.status!;
    });
    widget.onCancelTap();
  }
}
