import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:movie_alarm/model/observable/observable.dart';


class VideoController extends StatefulWidget {
  _VideoControllerState createState() => _VideoControllerState();

  final ObservableAlarm alarm;
  const VideoController({Key? key, required this.alarm}) : super(key: key);
}

class _VideoControllerState extends State<VideoController> {

  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=pQWTc6We2K8").toString(), //widget.alarm.videoPath
      flags: YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: true,
          loop: false,
          enableCaption: false),
    );

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.all(size.height * 0.02),
      child: Container(
        child: YoutubePlayer(
          controller: _controller,
          width: size.width * 0.5,
          showVideoProgressIndicator: true,
          bottomActions: <Widget>[
            // const SizedBox(width: 14.0),
            CurrentPosition(),
            // const SizedBox(width: 8.0),
            ProgressBar(isExpanded: true),
            RemainingDuration(),
          ],
          aspectRatio: 4 / 3,
          progressIndicatorColor: Colors.white,
          onReady: () {
            print('Player is ready.');
          },
        ),
      ),
    );
  }
}
