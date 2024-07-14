import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gloss_ll/src/models/subtitle.dart';
import 'package:gloss_ll/src/modules/playback_page/playback_page.dart';
import 'package:gloss_ll/src/util/constants.dart';
import 'package:gloss_ll/src/util/loading.dart';
import 'package:gloss_ll/src/util/secrets.dart';
import 'package:http/http.dart' as http;
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
  ProficiencyLevel _selectedProficiencyLevel = ProficiencyLevel.intermediate;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    widget.args;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configure Playback'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._buildProficiencySelector(),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });

                  final String srtContents =
                      await rootBundle.loadString(widget.args.srtPath);

                  final String openAiGlossedSrt =
                      await _getOpenAiResponse(srtContents);

                  final List<Subtitle> subtitles =
                      _extractSubtitles(openAiGlossedSrt);

                  _isLoading = false;
                  Navigator.pushNamed(
                    context,
                    "/playback",
                    arguments: PlaybackPageArguments(
                      subtitlesTitle: widget.args.srtPath
                          .split("/")[2]
                          .replaceAll(".srt", ""),
                      subtitles: subtitles,
                    ),
                  );
                },
                child: _isLoading
                    ? const Loading()
                    : const Text("Configure Playback"),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildProficiencySelector() {
    return <Widget>[
      ListTile(
        title: const Text('Beginner'),
        leading: Radio<ProficiencyLevel>(
          value: ProficiencyLevel.beginner,
          groupValue: _selectedProficiencyLevel,
          onChanged: (ProficiencyLevel? value) {
            if (value != null) {
              setState(() {
                _selectedProficiencyLevel = value;
              });
            }
          },
        ),
      ),
      ListTile(
        title: const Text('Intermediate'),
        leading: Radio<ProficiencyLevel>(
          value: ProficiencyLevel.intermediate,
          groupValue: _selectedProficiencyLevel,
          onChanged: (ProficiencyLevel? value) {
            if (value != null) {
              setState(() {
                _selectedProficiencyLevel = value;
              });
            }
          },
        ),
      ),
      ListTile(
        title: const Text('Advanced'),
        leading: Radio<ProficiencyLevel>(
          value: ProficiencyLevel.advanced,
          groupValue: _selectedProficiencyLevel,
          onChanged: (ProficiencyLevel? value) {
            if (value != null) {
              setState(() {
                _selectedProficiencyLevel = value;
              });
            }
          },
        ),
      ),
    ];
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

  Future<String> _getOpenAiResponse(String srtContents) async {
    var httpResponse = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $OPENAI_API_KEY',
        HttpHeaders.contentTypeHeader: 'application/json'
      },
      body: jsonEncode({
        // "model": "gpt-4o",
        "model": "gpt-3.5-turbo",
        "messages": [
          {
            "role": "user",
            "content": """
From the given SRT file, generate a new SRT file by selecting to show only subtitles that a  ${_selectedProficiencyLevel.name} language learner would learn. 
In the new subtitle chunk, provide in order:
- The original chunk
- The vocabulary word
- If the subtitle language is Chinese, then include the pinyin for the vocabulary word.
- If the language is not English, a translation in English.
- The definition of the word. If the language is not English, then provide the definition in English.
Strictly follow the SRT file format.
\n\n
$srtContents
"""
          }
        ],
        "temperature": 0.7,
      }),
    );
    print('OpenAI response');
    var responseBody = utf8.decode(httpResponse.bodyBytes);
    print(responseBody);
    return jsonDecode(responseBody)["choices"][0]['message']['content'];
  }

  int convertSrtTimeToMilis(String srtTime) {
    var millis = int.parse(srtTime.split(",")[1]);
    var seconds = int.parse(srtTime.split(",")[0].split(":")[2]);
    var minutes = int.parse(srtTime.split(",")[0].split(":")[1]);
    var hours = int.parse(srtTime.split(",")[0].split(":")[0]);

    return (hours * 3600000) + (minutes * 60000) + (seconds * 1000) + millis;
  }
}
