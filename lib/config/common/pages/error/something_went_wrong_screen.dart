import 'package:flutter/material.dart';

import '../../widgets/something_went_wrong.dart';

class SomethingWentWrong extends StatelessWidget {
  final String error;
  final String errorIcon;
  const SomethingWentWrong({
    Key? key,
    required this.error,
    this.errorIcon = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: somthingWentWrong(context, error, errorIcon: errorIcon),
      ),
    );
  }
}
