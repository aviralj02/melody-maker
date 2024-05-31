import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:melody_maker/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  PlaylistProvider() {
    listenToDuration();
  }

  final List<Song> _playlist = [
    Song(
      songName: "Besabriyaan",
      artistName: "Armaan Malik",
      albumArtImagePath:
          'assets/images/Besabriyaan-M.S.-Dhoni---The-Untold-Story.jpg',
      audioPath: 'audio/Besabriyaan.mp3',
    ),
    Song(
      songName: "Chahun Main Ya Naa",
      artistName: "Arijit Singh, Palak Muchhal",
      albumArtImagePath: 'assets/images/Chahun-Main-Ya-Naa-Aashiqui-2.jpg',
      audioPath: 'audio/Chahun Main Ya Naa Aashiqui 2 128 Kbps.mp3',
    ),
    Song(
      songName: "Jiya Laage Na",
      artistName: "Mohit Chauhan, Shilpa Rao",
      albumArtImagePath: 'assets/images/jiya-laage-na-2024-0425-500-500.jpg',
      audioPath: 'audio/Jiya Laage Na.mp3',
    ),
    Song(
      songName: "Mast Magan",
      artistName: "Arijit Singh",
      albumArtImagePath: 'assets/images/mast-magan-2states.jpg',
      audioPath: 'audio/Mast Magan 2 States 128 Kbps.mp3',
    ),
  ];

  int? _currentSongIndex;

  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;

  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;

    if (newIndex != null) {
      play();
    }
    notifyListeners();
  }

  // Audio Player
  final AudioPlayer _audioPlayer = AudioPlayer();

  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  bool _isPlaying = false;

  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  void play() async {
    final String path = _playlist[_currentSongIndex ?? 0].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
    notifyListeners();
  }

  void playNext() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        currentSongIndex = 0;
      }
    }
  }

  void playPrevious() {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      playNext();
      notifyListeners();
    });
  }
}
