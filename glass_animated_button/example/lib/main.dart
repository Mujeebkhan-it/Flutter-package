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
                    text: "Asset BG",
                    icon: Icon(Icons.image, color: Colors.white),
                    onPressed: () async {
                      setState(() => _loading = true);
                      await Future.delayed(const Duration(seconds: 2));
                      setState(() => _loading = false);
                    },
                    blur: 6,
                    borderRadius: 20,
                    color: Colors.white.withOpacity(0.15),
                    animationDuration: const Duration(milliseconds: 200),
                    animationCurve: Curves.easeInOut,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 16,
                        offset: Offset(0, 6),
                      ),
                    ],
                   
                    enableHapticFeedback: true,
                    isLoading: _loading,
                    isDisabled: _disabled,
                    backgroundImage: AssetImage('assets/btn_bg.jpg'),
                  ),
                  const SizedBox(height: 32),
                  GlassAnimatedButton(
                    text: "Network BG",
                    icon: Icon(Icons.cloud, color: Colors.white),
                    onPressed: () => setState(() => _disabled = !_disabled),
                    blur: 3,
                    borderRadius: 16,
                    color: Colors.white24,
                    isDisabled: _loading,
                    backgroundImage: NetworkImage("https://wallpaper-mania.com/wp-content/uploads/2018/09/High_resolution_wallpaper_background_ID_77701901704.jpg"),)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
