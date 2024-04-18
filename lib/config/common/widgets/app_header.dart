import 'package:flutter/material.dart';

import '../../constants.dart';
import 'app_logo.dart';

PreferredSize appHeader(
    {required BuildContext context,
    Widget leading = const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [AppIcon(height: 50), SizedBox(width: 5)]),
    bool leadingAvail = true,
    Color bgColor = Colors.transparent,
    required Widget body,
    required Widget trailing}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(80.0),
    child: SafeArea(
      child: Container(
        color: bgColor,
        child: Padding(
          padding: defaultPadding,
          child: Row(
            children: [
              if (leadingAvail) leading,
              Expanded(child: body),
              trailing,
            ],
          ),
        ),
      ),
    ),
  );
}
