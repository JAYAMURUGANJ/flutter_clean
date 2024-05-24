import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/common/widgets/bottom_sheet.dart';
import '../../../../config/constants.dart';
import '../../domain/entities/temple_info.dart';
import '../bloc/temple_info/temple_info_bloc.dart';
import '/config/common/widgets/full_screen_image_viewer.dart';
import '/features/temple_details/presentation/widgets/contact_details.dart';
import '/features/temple_details/presentation/widgets/main_tower.dart';
import '/features/temple_list/domain/entities/itms_response.dart';
import '360_degree_view.dart';
import 'google_map_location.dart';

Widget buildTempleImage(context, ItmsResponseEntity temple) {
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
                            templeInfo!.templeImages![0].fileLocation.toString()
                        : temple.maintowerImage!.isNotEmpty
                            ? ApiCredentials().documents +
                                temple.maintowerImage![0].fileLocation
                                    .toString()
                            : NetworkImages.templePlaceHolder,
                  );
                },
                child: CachedNetworkImage(
                  placeholder: (context, url) =>
                      const CupertinoActivityIndicator(),
                  imageUrl: state is TempleInfoLoaded
                      ? ApiCredentials().documents +
                          templeInfo!.templeImages![0].fileLocation.toString()
                      : temple.maintowerImage!.isNotEmpty
                          ? ApiCredentials().documents +
                              temple.maintowerImage![0].fileLocation.toString()
                          : NetworkImages.templePlaceHolder,
                  imageBuilder: (context, imageProvider) => ClipRRect(
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
                      SizedBox(
                        height: double.infinity,
                        child: ShowTemple360View(url: temple.degree360view!),
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
                      NearByTemplesWidget(
                        temple: temple,
                      ),
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
                    onPressed: () => buildBottomSheet(context, temple,
                        'contact', BuildContactDetails(temple)),
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
