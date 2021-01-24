import 'package:flutter/material.dart';

class OnboardingTextWidget extends StatelessWidget {
  final String text;

  OnboardingTextWidget({this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
