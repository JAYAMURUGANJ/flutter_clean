// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '/config/common/extensions.dart';
import '/config/constants.dart';

class PaymentSplashScreen extends StatefulWidget {
  const PaymentSplashScreen({Key? key}) : super(key: key);

  @override
  _PaymentSplashScreenState createState() => _PaymentSplashScreenState();
}

class _PaymentSplashScreenState extends State<PaymentSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  //late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, "/PayStatus");
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onPrimaryContainer,
        body: Center(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).width + 100,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                20.ph,
                Lottie.asset(
                  LottieImage().pop,
                  controller: _controller,
                  onLoaded: (composition) {
                    // Configure the AnimationController with the duration of the
                    // Lottie file and start the animation.
                    _controller.duration = composition.duration;
                  },
                ),
                Lottie.asset(
                  LottieImage().success,
                  controller: _controller,
                  width: 200,
                  onLoaded: (composition) {
                    // Configure the AnimationController with the duration of the
                    // Lottie file and start the animation.
                    _controller
                      ..duration = composition.duration
                      ..forward();
                  },
                ),
                20.ph,
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    "Payemt Success",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
