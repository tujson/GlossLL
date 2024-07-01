import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String text;

  const Loading({super.key, this.text = ''});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
        const Padding(
          padding: EdgeInsets.all(8),
        ),
        Text(
          text,
          key: const Key('loading text'),
          style: const TextStyle(
            fontSize: 24.0,
          ),
        ),
      ],
    );
  }
}
