# glass_animated_button

A beautiful animated button with a frosted glass (glassmorphism) effect.  
You can customize text, blur, color, and more.

## Features

- Tap animation with scale
- Blur glass effect using BackdropFilter
- Customizable color, text, borderRadius

## Usage

```dart
GlassAnimatedButton(
  text: "Click Me",
  onPressed: () {
    print("Tapped!");
  },
  blur: 10,
  borderRadius: 20,
  color: Colors.white.withOpacity(0.2),
)

