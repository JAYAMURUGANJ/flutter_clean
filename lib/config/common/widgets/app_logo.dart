import 'package:flutter/material.dart';

import '../../constants.dart';

class AppIcon extends StatelessWidget {
  final double height;
  const AppIcon({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      LocalImages().logo,
      height: height,
    );
  }
}
