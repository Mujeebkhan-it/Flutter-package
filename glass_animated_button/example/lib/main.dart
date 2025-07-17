import 'package:flutter/material.dart';
import 'package:glass_animated_button/glass_animated_button.dart';
import 'dart:ui';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _loading = false;
  bool _disabled = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/bg.jpg',
              fit: BoxFit.cover,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.2), // Optional dark overlay
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GlassAnimatedButton(
                    text: "Download",
                    icon: Icon(Icons.download, color: Colors.white),
                    onPressed: () async {
                      setState(() => _loading = true);
                      await Future.delayed(const Duration(seconds: 2));
                      setState(() => _loading = false);
                    },
                    blur: 10,
                    borderRadius: 20,
                    color: Colors.white.withOpacity(0.15),
                    animationDuration: const Duration(milliseconds: 200),
                    animationCurve: Curves.easeInOut,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 16,
                        offset: Offset(0, 6),
                      ),
                    ],
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF414345),
                        Color(0xFF6a11cb),
                        Color(0xFF2575fc),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    enableHapticFeedback: true,
                    isLoading: _loading,
                    isDisabled: _disabled,
                  ),
                  const SizedBox(height: 32),
                  GlassAnimatedButton(
                    text: _disabled ? "Disabled" : "Enable/Disable",
                    onPressed: () => setState(() => _disabled = !_disabled),
                    blur: 8,
                    borderRadius: 16,
                    color: Colors.white24,
                    isDisabled: _loading,
                    icon: Icon(Icons.lock, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
