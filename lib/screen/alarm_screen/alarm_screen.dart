import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:movie_alarm/Services/media_handler.dart';
import 'package:movie_alarm/components/default_container/default_container.dart';
import 'package:movie_alarm/model/alarmstatus/status.dart';
import 'package:movie_alarm/model/observable/observable.dart';
import 'package:movie_alarm/screen/video_screen/video_screen.dart';
import 'package:slide_button/slide_button.dart';
import 'package:wakelock/wakelock.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AlarmScreen extends StatefulWidget {
  final ObservableAlarm alarm;
  final MediaHandler mediaHandler;

  const AlarmScreen({Key? key, required this.alarm, required this.mediaHandler})
      : super(key: key);

  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  late final ObservableAlarm alarm;
  late final MediaHandler mediaHandler;

  @override
  void initState() {
    super.initState();

    alarm = widget.alarm;
    mediaHandler = widget.mediaHandler;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final format = DateFormat('Hm');
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image(
              colorBlendMode: BlendMode.dstATop,
              image: AssetImage("assets/images/alarm_background.png"),
              fit: BoxFit.cover,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Center(
                  child: Container(
                    width: 325,
                    height: 325,
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.alarm,
                          color: Colors.white,
                          size: 32,
                        ),
                        Text(
                          format.format(now),
                          style: TextStyle(fontSize: 52, color: Colors.white),
                        ),
                        Text(
                          alarm.name,
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: screenSize.width * 0.33,
                  height: screenSize.height * 0.06,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Opacity(
                      opacity: 0.7,
                      child: TextButton(
                        child: Text(
                          "알람 끄기",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () async {
                          mediaHandler.stopAlarm();
                          Wakelock.disable();

                          AlarmStatus().isAlarm = false;

                          //유튜브 링크가 존재할 경우 Controller로 이동
                          if (alarm.videoPath == "") {
                            SystemNavigator.pop();
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VideoScreen(alarm: alarm),
                              ),
                            );
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white30),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class AlarmScreen extends StatelessWidget {
//   final ObservableAlarm alarm;
//   final MediaHandler mediaHandler;
//
//   const AlarmScreen({Key? key, required this.alarm, required this.mediaHandler})
//       : super(key: key);
//
//
//
//
//   }
// }
