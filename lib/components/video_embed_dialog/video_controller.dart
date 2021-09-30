import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:movie_alarm/model/observable/observable.dart';

class VideoController extends StatefulWidget {
  _VideoControllerState createState() => _VideoControllerState();

  final ObservableAlarm alarm;
  final bool isAlarmScreen;

  const VideoController(
      {Key? key, required this.alarm, required this.isAlarmScreen})
      : super(key: key);
}

class _VideoControllerState extends State<VideoController> {
  late YoutubePlayerController _controller;
  late bool isAlarmScreen;

  @override
  void initState() {
    isAlarmScreen = widget.isAlarmScreen;

    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.alarm.videoPath)
          .toString(), //widget.alarm.videoPath
      flags: isAlarmScreen
          ? YoutubePlayerFlags(
              mute: false,
              autoPlay: true,
              disableDragSeek: true,
              loop: false,
              enableCaption: false)
          : YoutubePlayerFlags(
              mute: false,
              autoPlay: false,
              disableDragSeek: true,
              loop: false,
              enableCaption: false),
    );

    _controller.setVolume((widget.alarm.volume*100).toInt());

    if (isAlarmScreen && !_controller.value.isFullScreen) {
      _controller.toggleFullScreenMode();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        if (_controller.value.isFullScreen) {
          _controller.toggleFullScreenMode();
        } else {
          return true;
        }
        return false;

      },
      child: GestureDetector(
        child: Padding(
          padding: EdgeInsets.all(size.height * 0.02),
          child: Container(
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              bottomActions: <Widget>[
                // const SizedBox(width: 14.0),
                CurrentPosition(),
                // const SizedBox(width: 8.0),
                ProgressBar(isExpanded: true),
                RemainingDuration(),
                FullScreenButton(),
              ],
              aspectRatio: 4 / 3,
              progressIndicatorColor: Colors.white,
              onReady: () {
                print('Player is ready.');
              },
            ),
          ),
        ),
        onLongPress: (){

        },
      ),
    );
  }
}
