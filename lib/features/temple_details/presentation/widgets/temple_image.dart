import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/common/widgets/bottom_sheet.dart';
import '../../../../config/constants.dart';
import '../../domain/entities/temple_info.dart';
import '../bloc/temple_info/temple_info_bloc.dart';
import '/config/common/widgets/full_screen_image_viewer.dart';
import 'contacts.dart';
import '/features/temple_details/presentation/widgets/main_tower.dart';
import '360_degree_view.dart';
import 'google_map_location.dart';

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
              bottom: 30,
              left: 150,
              child: Card(
                child: Center(
                  child: IconButton(
                    onPressed: () => buildBottomSheet(
                      context,
                      temple,
                      '360',
                      const SizedBox(
                        height: double.infinity,
                        child: ShowTemple360View(
                            url:
                                'https://mylaikapaleeswarar.hrce.tn.gov.in/resources/docs/virtualtour/1/index.html'),
                      ),
                    ),
                    icon: Image.asset(
                      LocalImages().degreeView,
                      fit: BoxFit.cover,
                      width: 35,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 220,
              child: Card(
                child: Center(
                  child: IconButton(
                    onPressed: () => buildBottomSheet(
                      context,
                      temple,
                      'location',
                      const TempleMapLocation(),
                    ),
                    icon: Image.asset(
                      LocalImages().location,
                      width: 35,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 290,
              child: Card(
                child: Center(
                  child: IconButton(
                    onPressed: () => buildBottomSheet(
                      context,
                      temple,
                      'contact',
                      buildContactBody(context, temple),
                    ),
                    icon: Image.asset(
                      LocalImages().contact,
                      width: 35,
                    ),
                  ),
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
