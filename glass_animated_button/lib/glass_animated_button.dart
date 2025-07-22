library glass_animated_button;

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  /// The duration of the tap animation.
  final Duration animationDuration;

  /// The curve of the tap animation.
  final Curve animationCurve;

  /// Whether the button is in a loading state.
  final bool isLoading;

  /// Whether the button is disabled.
  final bool isDisabled;

  /// Optional shadow or glow effect for the button.
  final List<BoxShadow>? boxShadow;

  /// Optional gradient background for the button. Overrides [color] if provided.
  final Gradient? gradient;

  /// Whether to enable haptic feedback on tap.
  final bool enableHapticFeedback;

  /// Optional background image for the button (asset, network, etc.).
  final ImageProvider? backgroundImage;

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
    this.animationDuration = const Duration(milliseconds: 100),
    this.animationCurve = Curves.easeOut,
    this.isLoading = false,
    this.isDisabled = false,
    this.boxShadow,
    this.gradient,
    this.enableHapticFeedback = false,
    this.backgroundImage,
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
      duration: widget.animationDuration,
      lowerBound: 0.0,
      upperBound: 0.1,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: widget.animationCurve),
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
    final bool effectiveDisabled = widget.isDisabled || widget.isLoading;
    void handleTap() {
      if (widget.enableHapticFeedback) {
        HapticFeedback.lightImpact();
      }
      widget.onPressed();
    }

    return GestureDetector(
      onTap: effectiveDisabled ? null : handleTap,
      onTapDown: effectiveDisabled ? null : _onTapDown,
      onTapUp: effectiveDisabled ? null : _onTapUp,
      onTapCancel: effectiveDisabled ? null : _onTapCancel,
      child: FocusableActionDetector(
        enabled: !effectiveDisabled,
        onShowFocusHighlight: (_) => setState(() {}),
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.enter): ActivateIntent(),
          LogicalKeySet(LogicalKeyboardKey.space): ActivateIntent(),
        },
        actions: <Type, Action<Intent>>{
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (intent) => handleTap(),
          ),
        },
        child: Semantics(
          button: true,
          enabled: !effectiveDisabled,
          label: widget.text,
          value: widget.isLoading ? 'Loading' : null,
          child: AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) => Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
            ),
            child: Opacity(
              opacity: effectiveDisabled ? 0.6 : 1.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    if (widget.backgroundImage != null)
                      Positioned.fill(
                        child: Image(
                          image: widget.backgroundImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: widget.blur,
                        sigmaY: widget.blur,
                      ),
                      child: Container(
                        padding: widget.padding,
                        decoration: BoxDecoration(
                          color: widget.gradient == null && widget.backgroundImage == null ? widget.color : null,
                          gradient: widget.gradient,
                          borderRadius: BorderRadius.circular(widget.borderRadius),
                          border: Border.all(color: Colors.white24),
                          boxShadow: widget.boxShadow,
                        ),
                        child: widget.isLoading
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    widget.textStyle?.color ?? Colors.white,
                                  ),
                                  strokeWidth: 2.2,
                                ),
                              )
                            : Row(
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
