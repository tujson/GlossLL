import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    widget.args;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Text("ConfigurePlaybackPage"),
            Text("Args: ${widget.args.srtPath}"),
          ],
        ),
      ),
    ));
  }
}
