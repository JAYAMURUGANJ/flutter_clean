import 'package:flutter/material.dart';

import '../../constants.dart';
import '/config/common/widgets/network_image_cache.dart';

noDataAvailable(BuildContext context, String error) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsetsDirectional.only(
              start: 14, end: 14, bottom: 7, top: 7),
          height: MediaQuery.of(context).size.width / 2.2,
          child: buildImage(context, NetworkImages.noDataAvailable),
        ),
        Text(
          error,
          textAlign: TextAlign.center,
        )
      ],
    ),
  );
}
