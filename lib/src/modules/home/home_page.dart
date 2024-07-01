import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, "/select-subtitles"),
                  child: const Text(
                    "Select Subtitles",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
