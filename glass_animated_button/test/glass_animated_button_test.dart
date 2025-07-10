import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glass_animated_button/glass_animated_button.dart';

void main() {
  testWidgets('GlassAnimatedButton displays text', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GlassAnimatedButton(
            text: "Tap Me",
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(find.text("Tap Me"), findsOneWidget);
  });
}
