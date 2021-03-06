import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:mobx/mobx.dart';
import 'package:movie_alarm/model/music_selection/searchable_selection.dart';
import 'package:movie_alarm/model/observable/observable.dart';
import 'package:movie_alarm/screen/music_selection_screen/components/edit_alarm_slider.dart';
import 'package:movie_alarm/screen/music_selection_screen/components/music_list.dart';

bool songFilter(SongInfo info, String currentSearch) {
  final filter = RegExp(currentSearch, caseSensitive: false);
  return info.title.contains(filter) || info.displayName.contains(filter);
}

class MusicSelectionScreen extends StatelessWidget {
  final List<SongInfo> titles;
  final ObservableAlarm alarm;

  final SearchableSelectionStore<SongInfo> store;

  MusicSelectionScreen({Key? key, required this.titles, required this.alarm})
      : store = SearchableSelectionStore(
      titles,
      alarm.trackInfo.map((info) => info.id).toList(),
          (info) => info.id,
      songFilter),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    AudioPlayer _currentPlayer = AudioPlayer();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFe9ecef),
        elevation: 0,
        title: Text(
          "알람음",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          final newSelected = store.itemSelected.entries
              .where((entry) => entry.value)
              .map((entry) => entry.key);

          alarm.musicIds = ObservableList.of(newSelected);
          await alarm.loadTracks();
          _currentPlayer.stop();
          _currentPlayer.release();

          return true;

        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            MusicList(store: store, audioPlayer: _currentPlayer,),
        ],
        ),
      ),
    );
  }
}
