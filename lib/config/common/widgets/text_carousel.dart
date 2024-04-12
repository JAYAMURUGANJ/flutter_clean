// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';

class TextCarousel extends StatefulWidget {
  final List<String> texts;
  final Duration duration;
  final Curve animationCurve;

  const TextCarousel(
      {Key? key,
      required this.texts,
      this.duration = const Duration(seconds: 5),
      this.animationCurve = Curves.easeInOut})
      : super(key: key);

  @override
  _TextCarouselState createState() => _TextCarouselState();
}

class _TextCarouselState extends State<TextCarousel> {
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(widget.duration, (timer) {
      if (_currentPage < widget.texts.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: widget.duration,
        curve: widget.animationCurve,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 80,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.texts.length,
            itemBuilder: (context, index) {
              return Card(
                child: SizedBox(
                  width: 200,
                  child: Center(
                    child: Text(
                      widget.texts[index],
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 3.0),
        _buildIndicators(),
      ],
    );
  }

  Widget _buildIndicators() {
    List<Widget> indicators = [];
    for (int i = 0; i < widget.texts.length; i++) {
      indicators.add(
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPage == i
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey,
            ),
          ),
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indicators,
    );
  }
}
