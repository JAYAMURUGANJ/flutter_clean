import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../widgets/network_image_cache.dart';
import '../../widgets/something_went_wrong.dart';

class SomethingWentWrong extends StatelessWidget {
  final String error;
  const SomethingWentWrong({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: somthingWentWrong(context, error),
      ),
    );
  }
}
