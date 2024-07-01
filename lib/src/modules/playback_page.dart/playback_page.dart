import 'package:flutter/material.dart';

class PlaybackPageArguments {
  final String srtPath;

  PlaybackPageArguments({required this.srtPath});
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
              const Text("PlaybackPage"),
              Text("Args: ${widget.args}"),
            ],
          ),
        ),
      ),
    );
  }
}
