import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../config/constants.dart';

Widget buildTempleImage(context, temple) {
  return Container(
    height: 275,
    // color: Colors.amber,
    alignment: Alignment.topCenter,
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          top: 0,
          height: 220,
          width: MediaQuery.of(context).size.width,
          child: CachedNetworkImage(
            // imageUrl: temple!.maintowerImage![0].fileLocation.toString(),
            imageUrl: temple!.maintowerImage!.isNotEmpty
                ? ApiCredentials().documents +
                    temple!.maintowerImage![0].fileLocation.toString()
                : 'https://cdn-icons-png.freepik.com/512/89/89020.png',

            imageBuilder: (context, imageProvider) => ClipRRect(
              // borderRadius: BorderRadius.circular(20.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.08),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover)),
              ),
            ),
          ),
        ),
        Positioned(
            top: 8,
            right: -10,
            child: MaterialButton(
              onPressed: () {},
              shape: const CircleBorder(),
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Image.asset(
                "assets/images/icons/360_icon.png",
                width: 36,
                color: Theme.of(context).colorScheme.primary,
              ),
            )),
        Positioned(
          bottom: 15,
          left: 20,
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xffee2a7b),
                  Color(0xff6228d7),
                  Color(0xFFF9CE34)
                ],
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
                imageUrl: temple!.maintowerImage!.isNotEmpty
                    ? 'https://hrce.tn.gov.in/webservice/documentview.php?file_path=${temple!.maintowerImage![0].fileLocation}'
                    : 'https://cdn-icons-png.freepik.com/512/89/89020.png',

                imageBuilder: (context, imageProvider) => CircleAvatar(
                  radius: 46,
                  backgroundImage: imageProvider,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
