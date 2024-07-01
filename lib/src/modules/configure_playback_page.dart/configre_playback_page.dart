import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gloss_ll/src/models/subtitle.dart';
import 'package:gloss_ll/src/modules/playback_page.dart/playback_page.dart';
import 'package:intl/intl.dart';

class ConfigurePlaybackPageArguments {
  final String srtPath;

  ConfigurePlaybackPageArguments({required this.srtPath});
}

class ConfigurePlaybackPage extends StatefulWidget {
  final ConfigurePlaybackPageArguments args;

  const ConfigurePlaybackPage({super.key, required this.args});

  @override
  State<ConfigurePlaybackPage> createState() => _ConfigurePlaybackPageState();
}

class _ConfigurePlaybackPageState extends State<ConfigurePlaybackPage> {
  final Random _random = Random();

  @override
  Widget build(BuildContext context) {
    widget.args;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/select-subtitles");
              },
              icon: const Icon(
                Icons.chevron_left,
              ),
            ),
            const Text("ConfigurePlaybackPage"),
            Text("Args: ${widget.args.srtPath}"),
            ElevatedButton(
              onPressed: () async {
                String srtContents =
                    await rootBundle.loadString(widget.args.srtPath);

                List<Subtitle> subtitles = _extractSubtitles(srtContents);

                // TODO: Send API request to OpenAI to gloss subtitles according to user level.
                List<Subtitle> filteredSubtitles = [];
                for (var i = 0; i < subtitles.length; i++) {
                  if (_random.nextBool()) {
                    filteredSubtitles.add(subtitles[i]);
                  }
                }

                Navigator.pushNamed(
                  context,
                  "/playback",
                  arguments: PlaybackPageArguments(
                    subtitles: filteredSubtitles,
                  ),
                );
              },
              child: const Text("Start Playback"),
            )
          ],
        ),
      ),
    ));
  }

  List<Subtitle> _extractSubtitles(String srtContents) {
    List<Subtitle> subtitles = [];

    srtContents.split("\n\n").forEach((srtSubtitle) {
      List<String> srtSubtitleSplit = srtSubtitle.split("\n");
      if (srtSubtitleSplit.length < 3) {
        return;
      }

      List<String> subtitleTimings = srtSubtitleSplit[1].split(" --> ");

      subtitles.add(Subtitle(
        numericCounter: int.parse(srtSubtitleSplit[0]),
        startTime: convertSrtTimeToMilis(subtitleTimings[0]),
        endTime: convertSrtTimeToMilis(subtitleTimings[1]),
        contents: srtSubtitleSplit.sublist(2).join('\n'),
      ));
    });

    return subtitles;
  }

  int convertSrtTimeToMilis(String srtTime) {
    var millis = int.parse(srtTime.split(",")[1]);
    var seconds = int.parse(srtTime.split(",")[0].split(":")[2]);
    var minutes = int.parse(srtTime.split(",")[0].split(":")[1]);
    var hours = int.parse(srtTime.split(",")[0].split(":")[0]);

    return (hours * 3600000) + (minutes * 60000) + (seconds * 1000) + millis;
  }
}
