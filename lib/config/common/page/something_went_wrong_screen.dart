import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../widget/network_image_cache.dart';

class SomethingWentWrong extends StatelessWidget {
  final String error;
  const SomethingWentWrong({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsetsDirectional.only(
                start: 14, end: 14, bottom: 7, top: 7),
            height: MediaQuery.of(context).size.width / 2.2,
            child: buildImage(context, NetworkImages.somthingWentWrong),
          ),
          Text(
            error,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
