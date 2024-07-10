import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../constants.dart';

class Loader extends StatefulWidget {
  final AnimationController controller;
  const Loader({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .25,
        child: Lottie.asset(
          LottieImage().loading,
          controller: widget.controller,
          animate: true,
          repeat: true,
          onLoaded: (composition) {
            widget.controller
              ..duration = composition.duration
              ..repeat();
          },
        ),
      ),
    );
  }
}
