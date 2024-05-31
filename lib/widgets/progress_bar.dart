import 'package:flutter/material.dart';
import 'package:melody_maker/models/playlist_provider.dart';

class ProgressBar extends StatelessWidget {
  final PlaylistProvider value;
  const ProgressBar({super.key, required this.value});

  String formatTime(Duration duration) {
    String twoDigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTimed = "${duration.inMinutes}:$twoDigitSeconds";

    return formattedTimed;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatTime(value.currentDuration)),
                  const Icon(Icons.shuffle),
                  const Icon(Icons.repeat),
                  Text(formatTime(value.totalDuration)),
                ],
              ),
            ],
          ),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0),
          ),
          child: Slider(
            min: 0,
            max: value.totalDuration.inSeconds.toDouble(),
            value: value.currentDuration.inSeconds.toDouble(),
            activeColor: Colors.green,
            onChanged: (value) {},
            onChangeEnd: (newPos) {
              value.seek(Duration(seconds: newPos.toInt()));
            },
          ),
        )
      ],
    );
  }
}
