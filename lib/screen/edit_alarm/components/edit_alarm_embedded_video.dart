import 'package:flutter/material.dart';
import 'package:movie_alarm/components/video_embed_dialog/video_controller.dart';
import 'package:movie_alarm/components/video_embed_dialog/video_embed_dialog.dart';
import 'package:movie_alarm/components/video_embed_dialog/video_uploader.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movie_alarm/model/observable/observable.dart';

class EditAlarmEmbeddedVideo extends StatelessWidget {
  final ObservableAlarm alarm;

  const EditAlarmEmbeddedVideo({Key? key, required this.alarm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    final onDone = () {
      currentFocus.unfocus();
      showDialog(
          context: context,
          builder: (context) => VideoEmbedDialog(alarm: this.alarm));
    };

    return Observer(
      builder: (context) => Container(
        child: alarm.videoPath == ''
            ? VideoUploader(
                onDone: onDone,
              )
            : VideoController(alarm: this.alarm, isAlarmScreen: false,),
      ),
    );
  }
}
