import 'package:flutter/material.dart';

import '../../constants.dart';
import 'network_image_cache.dart';

Center somthingWentWrong(BuildContext context, String error) {
  return Center(
    child: Column(
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
