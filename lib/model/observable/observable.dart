import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

/// 이 구문은 `User` 클래스가 생성된 파일의 private 멤버들을
/// 접근할 수 있도록 해줍니다. 여기에는 *.g.dart 형식이 들어갑니다.
/// * 에는 소스 파일의 이름이 들어갑니다.
part 'observable.g.dart';

/// 코드 생성기에 이 클래스가 JSON 직렬화 로직이 만들어져야 한다고 알려주는 어노테이션입니다.
@JsonSerializable()
class ObservableAlarm extends ObservableAlarmBase with _$ObservableAlarm {
  ObservableAlarm(
      {id,
      name,
      hour,
      minute,
      monday,
      tuesday,
      wednesday,
      thursday,
      friday,
      saturday,
      sunday,
      volume,
      active,
      musicIds,
      musicPaths,
      videoPath})
      : super(
            id: id,
            name: name,
            hour: hour,
            minute: minute,
            monday: monday,
            tuesday: tuesday,
            wednesday: wednesday,
            thursday: thursday,
            friday: friday,
            saturday: saturday,
            sunday: sunday,
            volume: volume,
            active: active,
            musicIds: musicIds?.cast<String>(),
            musicPaths: musicPaths?.cast<String>(),
            videoPath: videoPath);

  ObservableAlarm.dayList(
      id, name, hour, minute, volume, active, weekdays, musicIds, musicPaths, videoPath)
      : super(
            id: id,
            name: name,
            hour: hour,
            minute: minute,
            volume: volume,
            active: active,
            monday: weekdays[0],
            tuesday: weekdays[1],
            wednesday: weekdays[2],
            thursday: weekdays[3],
            friday: weekdays[4],
            saturday: weekdays[5],
            sunday: weekdays[6],
            musicIds: musicIds,
            musicPaths: musicPaths,
            videoPath: videoPath);

  factory ObservableAlarm.fromJson(Map<String, dynamic> json) =>
      _$ObservableAlarmFromJson(json);

  Map<String, dynamic> toJson() => _$ObservableAlarmToJson(this);
}

abstract class ObservableAlarmBase with Store {
  int id;

  @observable
  String name;

  @observable
  int hour;

  @observable
  int minute;

  @observable
  bool monday;

  @observable
  bool tuesday;

  @observable
  bool wednesday;

  @observable
  bool thursday;

  @observable
  bool friday;

  @observable
  bool saturday;

  @observable
  bool sunday;

  @observable
  double volume;

  @observable
  bool active;

  @observable
  String videoPath;

  /// Field holding the IDs of the playlists that were added to the alarm
  /// This is used for JSON serialization as well as retrieving the music from
  /// the playlist when the alarm goes off
  late List<String> playlistIds;

  /// Field holding the IDs of the soundfiles that should be loaded
  /// This is exclusively used for JSON serialization
  List<String> musicIds;

  /// Field holding the paths of the soundfiles that should be loaded.
  /// musicIds cannot be used in the alarm callback because of a weird
  /// interaction between flutter_audio_query and android_alarm_manager
  /// See Stack Overflow post here: https://stackoverflow.com/q/60203223/6707985
  List<String> musicPaths;



  @observable
  @JsonKey(ignore: true)
  ObservableList<SongInfo> trackInfo = ObservableList();

  @observable
  @JsonKey(ignore: true)
  ObservableList<PlaylistInfo> playlistInfo = ObservableList();

  ObservableAlarmBase(
      {required this.id,
      required this.name,
      required this.hour,
      required this.minute,
      required this.monday,
      required this.tuesday,
      required this.wednesday,
      required this.thursday,
      required this.friday,
      required this.saturday,
      required this.sunday,
      required this.volume,
      required this.active,
      required this.musicIds,
      required this.musicPaths,
      required this.videoPath});

  @action
  void removeItem(SongInfo info) {
    trackInfo.remove(info);
    trackInfo = trackInfo;
  }

  @action
  void removePlaylist(PlaylistInfo info) {
    playlistInfo.remove(info);
    playlistInfo = playlistInfo;
  }

  @action
  void reorder(int oldIndex, int newIndex) {
    final path = trackInfo[oldIndex];
    trackInfo.removeAt(oldIndex);
    trackInfo.insert(newIndex, path);
    trackInfo = trackInfo;
  }

  @action
  uploadVideo(String path) async {
    this.videoPath = path;
  }

  @action
  loadTracks() async {
    if (musicIds.length == 0) {
      trackInfo = ObservableList();
      return;
    }

    // Workaround for https://github.com/sc4v3ng3r/flutter_audio_query/issues/16
    if (musicIds.length == 1) {
      musicIds.add("");
    }

    final songs = await FlutterAudioQuery().getSongsById(ids: musicIds);
    trackInfo = ObservableList.of(songs);
  }

  @action
  loadPlaylists() async {
    if (playlistIds.length == 0) {
      playlistInfo = ObservableList();
      return;
    }

    final playlists = await FlutterAudioQuery().getPlaylists();
    playlistInfo = ObservableList.of(
        playlists.where((info) => playlistIds.contains(info.id)));
  }

  updateMusicPaths() {
    musicIds = trackInfo.map((SongInfo info) => info.id).toList();
    musicPaths = trackInfo.map((SongInfo info) => info.filePath).toList();
    playlistIds = playlistInfo.map((info) => info.id).toList();
  }

  List<bool> get days {
    return [monday, tuesday, wednesday, thursday, friday, saturday, sunday];
  }

  // Good enough for debugging for now
  toString() {
    return "active: $active, music: $musicPaths";
  }
}
