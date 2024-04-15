import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/config/common/widgets/full_screen_image_viewer.dart';

import '../../../../config/constants.dart';
import '../../domain/entities/temple_info.dart';
import '../bloc/temple_info/temple_info_bloc.dart';

Widget buildTempleImage(context, temple) {
  return BlocBuilder<TempleInfoBloc, TempleInfoState>(
    builder: (context, state) {
      TempleInfoEntity? templeInfo;
      if (state is TempleInfoLoaded) {
        templeInfo = state.templeInfo![0];
      }
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
              child: GestureDetector(
                onTap: () {
                  fullScreenImageViewer(
                      context,
                      state is TempleInfoLoaded
                          ? ApiCredentials().documents +
                              templeInfo!.templeImages![0].fileLocation
                                  .toString()
                          : temple!.maintowerImage!.isNotEmpty
                              ? ApiCredentials().documents +
                                  temple!.maintowerImage![0].fileLocation
                                      .toString()
                              : 'https://cdn-icons-png.freepik.com/512/89/89020.png');
                },
                child: CachedNetworkImage(
                  placeholder: (context, url) =>
                      const CupertinoActivityIndicator(),
                  imageUrl: state is TempleInfoLoaded
                      ? ApiCredentials().documents +
                          templeInfo!.templeImages![0].fileLocation.toString()
                      : temple!.maintowerImage!.isNotEmpty
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
              ),
            ),
            Positioned(
                bottom: 65,
                right: -10,
                child: MaterialButton(
                  onPressed: () {},
                  shape: const CircleBorder(),
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Image.asset(
                    "assets/images/icons/location_1.png",
                    width: 32,
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
    },
  );
}
