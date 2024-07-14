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
      appBar: AppBar(
        title: const Text('GlossLL'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, "/select-subtitles"),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 80)),
                  child: const Text(
                    "Select Subtitles",
                    style: TextStyle(fontSize: 24),
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
