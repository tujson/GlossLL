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
              const Text("PlaybackPage"),
              Text("Args: ${widget.args}"),
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.args.subtitles.length,
                itemBuilder: (context, index) {
                  return Text(widget.args.subtitles[index].contents + "\n");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
