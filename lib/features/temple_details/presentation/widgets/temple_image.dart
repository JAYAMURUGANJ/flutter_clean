import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/config/common/widgets/full_screen_image_viewer.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/widgets/bottom_sheet.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/widgets/main_tower.dart';

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
                  width: 35,
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
                    child: IconButton(
                      onPressed: (() {}),
                      icon: Icon(Icons.location_on_outlined,
                          size: 35,
                          color: Theme.of(context).colorScheme.primary),
                    ))),
            Positioned(
              bottom: 140,
              right: 10,
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: () => buildContactBottomSheet(context, temple),
                  icon: Icon(Icons.contact_phone_sharp,
                      size: 35, color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),

            // gopuram icon
            Positioned(
              bottom: 15,
              left: 20,
              child: mainTower(temple, 46),
            ),
          ],
        ),
      );
    },
  );
}
