import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:movie_alarm/model/observable/observable.dart';

class MusicListItem extends StatelessWidget {

  final SongInfo musicInfo;
  final ObservableAlarm alarm;

  const MusicListItem({Key? key, required this.musicInfo, required this.alarm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Icon(Icons.music_note),
        Text(this.musicInfo.title ?? this.musicInfo.displayName),
      ],
    );
  }

}
