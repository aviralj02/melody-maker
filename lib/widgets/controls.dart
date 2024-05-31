import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:melody_maker/models/playlist_provider.dart';
import 'package:melody_maker/widgets/neu_box.dart';

class Controls extends StatelessWidget {
  final PlaylistProvider value;
  const Controls({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              value.playPrevious();
            },
            child: NeuBox(
              child: Icon(Icons.skip_previous),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () {
              value.pauseOrResume();
            },
            child: NeuBox(
              child: Icon(value.isPlaying ? Icons.pause : Icons.play_arrow),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              value.playNext();
            },
            child: const NeuBox(
              child: Icon(Icons.skip_next),
            ),
          ),
        ),
      ],
    );
  }
}
