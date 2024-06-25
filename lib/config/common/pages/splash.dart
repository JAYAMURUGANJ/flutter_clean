// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../../constants.dart';
import '../class/local_storage.dart';
import '../widgets/app_header.dart';
import '/config/common/widgets/app_logo.dart';

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
      Navigator.pushReplacementNamed(context,
          Prefs.getBool(spOnBoardingStatus) ?? false ? "Home" : "/OnBoarding");
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
        body: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  LocalImages().splashBg,
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
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                    ),
                  ),
                ),
                trailing: Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    LocalImages().tnLogo,
                    height: 50,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
