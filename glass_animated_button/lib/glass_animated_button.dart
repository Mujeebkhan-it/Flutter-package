library glass_animated_button;

import 'dart:ui';
import 'package:flutter/material.dart';

/// A stylish, animated button with a frosted glass (glassmorphism) effect.
///
/// This widget supports blur, scaling animation on tap, optional icons,
/// customizable text styling, and rounded corners.
class GlassAnimatedButton extends StatefulWidget {
  /// The text displayed inside the button.
  final String text;

  /// Called when the button is tapped.
  final VoidCallback onPressed;

  /// The intensity of the blur effect.
  ///
  /// Higher values make the background more blurry.
  final double blur;

  /// The border radius of the button's corners.
  final double borderRadius;

  /// The semi-transparent background color of the button.
  final Color color;

  /// Custom text style for the button label.
  final TextStyle? textStyle;

  /// Padding around the button content (icon and text).
  final EdgeInsetsGeometry padding;

  /// Optional icon displayed before the text.
  final Widget? icon;

  /// Creates a [GlassAnimatedButton] with customizable glass effect and animation.
  const GlassAnimatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.blur = 10.0,
    this.borderRadius = 16.0,
    this.color = Colors.white24,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    this.icon,
  });

  @override
  State<GlassAnimatedButton> createState() => _GlassAnimatedButtonState();
}

class _GlassAnimatedButtonState extends State<GlassAnimatedButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.1,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) => _controller.forward();
  void _onTapUp(TapUpDetails details) => _controller.reverse();
  void _onTapCancel() => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: widget.blur,
              sigmaY: widget.blur,
            ),
            child: Container(
              padding: widget.padding,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(widget.borderRadius),
                border: Border.all(color: Colors.white24),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.icon != null) ...[
                    widget.icon!,
                    const SizedBox(width: 8),
                  ],
                  Text(
                    widget.text,
                    style: widget.textStyle ??
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
