import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '/config/constants.dart';

mainTower(dynamic temple, double radius) {
  return Container(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xffee2a7b), Color(0xff6228d7), Color(0xFFF9CE34)],
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.6),
          spreadRadius: 3,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
      shape: BoxShape.circle,
    ),
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: CachedNetworkImage(
        // imageUrl: temple!.maintowerImage![0].fileLocation.toString(),
        imageUrl: temple.maintowerImage!.isNotEmpty
            ? 'https://hrce.tn.gov.in/webservice/documentview.php?file_path=${temple.maintowerImage![0].fileLocation}'
            : NetworkImages.templePlaceHolder,

        imageBuilder: (context, imageProvider) => CircleAvatar(
          radius: radius,
          backgroundImage: imageProvider,
        ),
      ),
    ),
  );
}
