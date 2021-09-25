import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movie_alarm/model/music_selection/searchable_selection.dart';

class MusicList extends StatelessWidget {
  final SearchableSelectionStore<SongInfo> store;
  final AudioPlayer audioPlayer;

  MusicList({Key? key, required this.store, required this.audioPlayer})
      : super(key: key);

  late String selectedId;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Observer(
          builder: (context) => ListView(
            shrinkWrap: true,
            children: store.filteredIds.map(widgetForSongId).toList(),
          ),
        ),
      ),
    );
  }

  Widget widgetForSongId(String id) {
    final List<SongInfo> titles = store.availableItems;
    final title = titles.firstWhere((info) => info.id == id);

    return RadioListTile(
      value: title.id,
      title: Text(title.title ?? title.displayName),
      groupValue: store.selectedId,
      onChanged: (value) async {

        audioPlayer.stop();
        audioPlayer.release();

        audioPlayer.setReleaseMode(ReleaseMode.LOOP);

        final fixedPath = File(title.filePath.toString()).absolute.path;
        await audioPlayer.setUrl(fixedPath, isLocal: true);
        audioPlayer.play(fixedPath, isLocal: true, volume: 1.0);

        store.itemSelected[store.selectedId] = false; //기존 항목 false 로 바꿔주고
        store.itemSelected[title.id] = true; // 새로운 id true 로 변경
        store.selectedId = value.toString();
      },
    );
  }
}
