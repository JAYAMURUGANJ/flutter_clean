// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:news_app_clean_architecture/config/common/widgets/app_logo.dart';

import 'config/common/widgets/app_header.dart';
import 'config/constants.dart';
import 'config/theme/text_theme.g.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  //late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );
    // _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    // _controller.forward();

    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, "Home");
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/images/bg/splash.jpg',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            appHeader(
              context: context,
              leading: const Align(
                  alignment: Alignment.topLeft, child: AppIcon(height: 55)),
              body: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: LocaleText(
                    "thirukoil",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.w800,
                        foreground: Paint()..shader = linearGradient),
                  ),
                ),
              ),
              trailing: Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  LocalImages().tnLogo,
                  height: 55,
                ),
              ),
            ),
            // Center(
            //   child: FadeTransition(
            //     opacity: _animation,
            //     child: const FlutterLogo(
            //       size: 200,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
