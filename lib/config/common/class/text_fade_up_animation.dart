import 'package:flutter/material.dart';

class TextFadeUpAnimationWidget extends StatefulWidget {
  final String text;
  const TextFadeUpAnimationWidget({Key? key, required this.text})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TextFadeUpAnimationWidgetState createState() =>
      _TextFadeUpAnimationWidgetState();
}

class _TextFadeUpAnimationWidgetState extends State<TextFadeUpAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final ValueNotifier<bool> _isVisible = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.2, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Trigger the animation after a short delay
    Future.delayed(const Duration(milliseconds: 500), () {
      _isVisible.value = true;
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _isVisible,
        builder: (context, value, child) {
          return Center(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Opacity(
                  opacity: _isVisible.value ? 1.0 : 0.0,
                  child: Transform.translate(
                    offset: Offset(0, _animation.value * 100),
                    child: child,
                  ),
                );
              },
              child: Text(
                widget.text,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w400),
              ),
            ),
          );
        });
  }
}
