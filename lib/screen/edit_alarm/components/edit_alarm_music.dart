import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movie_alarm/model/observable/observable.dart';
import 'package:movie_alarm/screen/edit_alarm/components/music_list_item.dart';
import 'package:movie_alarm/screen/music_selection_screen/music_selection_screen.dart';

enum SelectionMode { SINGLE, PLAYLIST }

class EditAlarmMusic extends StatelessWidget {
  final ObservableAlarm alarm;

  EditAlarmMusic({Key? key, required this.alarm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    FocusScopeNode currentFocus = FocusScope.of(context);

    return Observer(
      builder: (context) => Material(
        type: MaterialType.transparency,
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "알람음",
                ),
                new MusicListItem(
                  alarm: alarm,
                  musicInfo: alarm.trackInfo.first,
                  key: Key(alarm.trackInfo.first.id),
                ),
              ],
            ),
          ),
          onTap: () async {
            currentFocus.unfocus();

            final audioQuery = FlutterAudioQuery();
            final songs =
                await audioQuery.getSongs(sortType: SongSortType.DISPLAY_NAME);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MusicSelectionScreen(titles: songs, alarm: alarm),
              ),
            );
          },
        ),
      ),
    );
  }
}
