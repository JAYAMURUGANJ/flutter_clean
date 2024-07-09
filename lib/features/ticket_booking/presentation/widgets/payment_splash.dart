// ignore_for_file: library_private_types_in_public_api

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

    // Timer(const Duration(seconds: 2), () {
    //   Navigator.pushReplacementNamed(context, "/PayStatus");
    // });
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            20.ph,
            Lottie.asset(
              LottieImage().success,
              controller: _controller,
              width: 500,
              onLoaded: (composition) {
                // Configure the AnimationController with the duration of the
                // Lottie file and start the animation.
                _controller
                  ..duration = composition.duration
                  ..forward();
              },
            ),
            Align(
              alignment: AlignmentDirectional.center,
              child: Text(
                "Done",
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: Colors.white)
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            5.ph,
            Align(
              alignment: AlignmentDirectional.center,
              child: Text(
                "Your ticket purchase\n successfully completed",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Colors.grey),
              ),
            ),
            100.ph,
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.8,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.white),
                ),
                onPressed: () =>
                    //  Navigator.pushReplacementNamed(context, "/loading"),

                    Navigator.pushReplacementNamed(context, "/PayStatus"),
                child: Text(
                  'View Ticket',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
