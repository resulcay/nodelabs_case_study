import 'package:flutter/material.dart';

class PrettyLoadingBar extends StatefulWidget {
  const PrettyLoadingBar({
    this.height = 8.0,
    this.startColor = Colors.blue,
    this.endColor = Colors.pink,
    this.animationDuration = const Duration(seconds: 2),
    this.width,
    super.key,
  });
  final double height;
  final Color startColor;
  final Color endColor;
  final Duration animationDuration;
  final double? width;

  @override
  State<PrettyLoadingBar> createState() => _PrettyLoadingBarState();
}

class _PrettyLoadingBarState extends State<PrettyLoadingBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = widget.width ?? constraints.maxWidth;

        return AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              height: widget.height,
              width: width * _animation.value,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [widget.startColor, widget.endColor],
                ),
                borderRadius: BorderRadius.circular(widget.height / 2),
              ),
            );
          },
        );
      },
    );
  }
}
