import 'package:flutter/material.dart';

class TextSlideAnimationWidget extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final Color? textColor;
  const TextSlideAnimationWidget(
      {Key? key, required this.text, required this.textStyle, this.textColor})
      : super(key: key);

  @override
  State<TextSlideAnimationWidget> createState() =>
      _TextSlideAnimationWidgetState();
}

class _TextSlideAnimationWidgetState extends State<TextSlideAnimationWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<RelativeRect> textPositionAnimation;
  late Size size;
  late double textWidth;
  late double textHeight;
  final double heightFactor = 1;
  final double widthFactor = 1;
  final ValueNotifier<MapEntry<double, double>> _positionNotifier =
      ValueNotifier(const MapEntry(0.0, 0.0));

  @override
  void initState() {
    setTextWidthAndHeight(widget.text, widget.textStyle);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _controller.forward();
    _startAnimation();
    super.initState();
    textPositionAnimation = RelativeRectTween(
      begin: RelativeRect.fromSize(
        Rect.fromLTWH(0, textHeight, textWidth, textHeight),
        Size(textWidth, textHeight),
      ),
      end: RelativeRect.fromSize(
        Rect.fromLTWH(0, 0, textWidth, textHeight),
        Size(textWidth, textHeight),
      ),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.9, curve: Curves.fastOutSlowIn),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void setTextWidthAndHeight(String text, TextStyle style) {
    size = textSize(
      text: text,
      style: style,
      maxWidth: double.infinity,
    );
    textWidth = size.width * widthFactor;
    textHeight = size.height * heightFactor;
  }

  void _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 100));
    _positionNotifier.value = MapEntry(0, textWidth);
    await Future.delayed(const Duration(milliseconds: 300));
    _positionNotifier.value = MapEntry(textWidth, 0);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: textHeight,
      child: Stack(
        children: [
          PositionedTransition(
              rect: textPositionAnimation,
              child: Text(
                widget.text,
                style: widget.textStyle,
                maxLines: 2,
              )),
          Container(
            height: textHeight,
            width: textWidth,
            color: Colors.transparent,
          ),
          ValueListenableBuilder<MapEntry<double, double>>(
              valueListenable: _positionNotifier,
              builder: (context, value, child) {
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  left: value.key,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    width: value.value,
                    height: textHeight,
                    color: widget.textColor ?? Colors.white,
                  ),
                );
              })
        ],
      ),
    );
  }

  static Size textSize({
    required String text,
    required TextStyle? style,
    double maxWidth = double.infinity,
  }) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: maxWidth);
    return textPainter.size;
  }
}
