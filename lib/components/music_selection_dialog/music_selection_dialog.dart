import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:movie_alarm/components/music_selection_dialog/dialog_base.dart';
import 'package:movie_alarm/model/music_selection/searchable_selection.dart';
import 'package:movie_alarm/model/observable/observable.dart';

bool songFilter(SongInfo info, String currentSearch) {
  final filter = RegExp(currentSearch, caseSensitive: false);
  return info.title.contains(filter) || info.displayName.contains(filter);
}

class MusicSelectionDialog extends StatelessWidget {
  final List<SongInfo> titles;
  final ObservableAlarm alarm;

  final SearchableSelectionStore<SongInfo> store;

  MusicSelectionDialog({Key? key, required this.titles, required this.alarm})
      : store = SearchableSelectionStore(
            titles,
            alarm.trackInfo.map((info) => info.id).toList(),
            (info) => info.id,
            songFilter),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final onDone = () {
      final newSelected = store.itemSelected.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key);

      alarm.musicIds = ObservableList.of(newSelected);
      alarm.loadTracks();
    };

    print('test:' + store.toString());

    return DialogBase(
      onDone: onDone,
      child: MusicList(store: store),
      onSearchClear: () => store.clearSearch(),
    );
  }
}

class MusicList extends StatelessWidget {
  final SearchableSelectionStore<SongInfo> store;

  const MusicList({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => ListView(
        shrinkWrap: true,
        children: store.filteredIds.map(widgetForSongId).toList(),
      ),
    );
  }

  Widget widgetForSongId(String id) {
    final List<SongInfo> titles = store.availableItems;
    final title = titles.firstWhere((info) => info.id == id);

    return Observer(
        builder: (context) => CheckboxListTile(
              value: store.itemSelected[title.id] ?? false,
              title: Text(title.title ?? title.displayName),
              onChanged: (newValue) {
                store.itemSelected[title.id] = newValue!;
              },
            ));
  }
}
