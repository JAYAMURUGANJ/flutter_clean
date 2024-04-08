import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'app_logo.dart';

PreferredSize appHeader(
    {required BuildContext context,
    Widget leading = const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [AppIcon(height: 60), SizedBox(width: 5)]),
    required Widget body,
    required Widget trailing}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(80.0),
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            leading,
            Expanded(child: body),
            trailing,
          ],
        ),
      ),
    ),
  );
}
