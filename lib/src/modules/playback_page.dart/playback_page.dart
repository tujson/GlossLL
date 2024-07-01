import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gloss_ll/src/models/subtitle.dart';

class PlaybackPageArguments {
  final List<Subtitle> subtitles;

  PlaybackPageArguments({required this.subtitles});
}

class PlaybackPage extends StatefulWidget {
  final PlaybackPageArguments args;

  const PlaybackPage({super.key, required this.args});

  @override
  State<PlaybackPage> createState() => _PlaybackPageState();
}

class _PlaybackPageState extends State<PlaybackPage> {
  final Stopwatch _stopwatch = Stopwatch();
  late Timer _t;
  int _currSubtitleIndex = 0;
  bool _isShowSubtitle = false;

  @override
  void initState() {
    super.initState();
    _stopwatch.reset();
    _t = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      // TODO: Don't call setState... Use Provider to re-render specific components.
      setState(() {
        for (var i = _currSubtitleIndex;
            i < widget.args.subtitles.length;
            i++) {
          var potentialSubtitle = widget.args.subtitles[i];
          if (potentialSubtitle.startTime < _stopwatch.elapsedMilliseconds &&
              _stopwatch.elapsedMilliseconds < potentialSubtitle.endTime) {
            _currSubtitleIndex = i;
            _isShowSubtitle = true;
            break;
          }
          _isShowSubtitle = false;
        }
      });
    });
    _currSubtitleIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
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
              const Text("PlaybackPage"),
              Text(_stopwatch.elapsedMilliseconds.toString()),
              Text(
                _isShowSubtitle
                    ? widget.args.subtitles[_currSubtitleIndex].contents
                    : "",
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _stopwatch.isRunning ? _stopwatch.stop() : _stopwatch.start();
                },
                child: const Text("Toggle Plaback"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
