import 'package:flutter/material.dart';
import 'package:glass_animated_button/glass_animated_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal[900],
        body: Center(
          child: GlassAnimatedButton(
            text: "Download",
            icon: Icon(Icons.download, color: Colors.white),
            onPressed: () => print("Tapped!"),
            blur: 10,
            borderRadius: 20,
            color: Colors.white.withOpacity(0.15),
          ),
        ),
      ),
    );
  }
}
