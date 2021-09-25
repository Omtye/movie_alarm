import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movie_alarm/model/observable/observable.dart';

class VideoEmbedDialog extends StatelessWidget {
  final ObservableAlarm alarm;

  const VideoEmbedDialog({Key? key, required this.alarm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return Container(
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    TextButton(
                      onPressed: () {},
                      child: Text('링크 임베드'),
                    ),
                  ],
                ),
                TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '동영상 링크를 붙여주세요',
                  ),
                ),
                TextButton(
                    onPressed: () {
                      alarm.uploadVideo(textController.text);
                      Navigator.of(context).pop();
                    },
                    child: Text('동영상 임베드'))
              ],
            )),
      ),
    );
  }
}
