import 'package:flutter/material.dart';
import 'package:movie_alarm/components/video_embed_dialog/video_controller.dart';
import 'package:movie_alarm/model/observable/observable.dart';

class VideoScreen extends StatelessWidget {
  final ObservableAlarm alarm;

  const VideoScreen({Key? key, required this.alarm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: VideoController(alarm: alarm),
      ),
    );
  }
}
