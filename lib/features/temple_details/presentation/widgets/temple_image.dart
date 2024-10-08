import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../../../dashboard/presentation/widgets/service_list.dart';
import '../../../temple_list/domain/entities/temple_list.dart';
import '../../data/model/location_info.dart';
import '../../domain/entities/speciality.dart';
import '../../domain/entities/temple_info.dart';
import '../bloc/speciality/speciality_bloc.dart';
import '../bloc/temple_info/temple_info_bloc.dart';
import '/config/common/extensions.dart';
import '/config/common/widgets/bottom_sheet.dart';
import '/config/common/widgets/full_screen_image_viewer.dart';
import '/config/constants.dart';
import '/features/temple_details/presentation/widgets/contact_details.dart';
import '/features/temple_details/presentation/widgets/main_tower.dart';
import '360_degree_view.dart';

Widget buildTempleImage(
    context,
    TempleEntity temple,
    AnimationController buttonAnimationController,
    Animation<Color?> colorAnimation) {
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
                            : LocalImages().templePlaceHolder,
                  );
                },
                child: CachedNetworkImage(
                  placeholder: (context, url) =>
                      const CupertinoActivityIndicator(),
                  imageUrl: state is TempleInfoLoaded
                      ? templeInfo!.templeImages!.isNotEmpty
                          ? ApiCredentials().documents +
                              templeInfo.templeImages![0].fileLocation
                                  .toString()
                          : LocalImages().templePlaceHolder
                      : temple.maintowerImage!.isNotEmpty
                          ? ApiCredentials().documents +
                              temple.maintowerImage![0].fileLocation.toString()
                          : LocalImages().templePlaceHolder,
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
                    onPressed: () {
                      pageNavigation("/NearByTemples", context,
                          arguments:
                              LocationInfo(fromCurrent: false, temple: temple));
                    },
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
            // speciality button
            Positioned(
              top: 0,
              left: 10,
              child: BlocBuilder<SpecialityBloc, SpecialityState>(
                builder: (context, state) {
                  if (state is SpecialityLoaded) {
                    List<SpecialityEntity> specialityList =
                        state.speciality!.cast<SpecialityEntity>();
                    if (specialityList.isNotEmpty) {
                      return MaterialButton(
                        height: 30,
                        minWidth: 1,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        onPressed: () {
                          pageNavigation("/Speciality", context,
                              arguments: specialityList);
                        },
                        child: AnimatedBuilder(
                            animation: buttonAnimationController,
                            builder: (context, child) {
                              return Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.sparkles,
                                    color: colorAnimation.value,
                                  ),
                                  LocaleText(
                                    "speciality",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: colorAnimation.value,
                                            fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              );
                            }),
                      );
                    }
                  }
                  return 0.pw;
                },
              ),
            ),

            //photo & video gallery button

            Positioned(
                top: 5,
                right: -20,
                child: Column(
                  children: [
                    MaterialButton(
                        onPressed: () {
                          pageNavigation("/PhotoGallery", context,
                              arguments: temple);
                          // buildBottomSheet(context, temple, 'photo_gallery',
                          //     PhotoGalleryWidget(templeData: temple));
                        },
                        elevation: 4,
                        height: 38,
                        shape: const CircleBorder(),
                        color: Colors.white,
                        child: Icon(
                          CupertinoIcons.photo_on_rectangle,
                          color: Theme.of(context).colorScheme.primary,
                          size: 24,
                        )),
                    MaterialButton(
                        onPressed: () {},
                        elevation: 4,
                        height: 38,
                        shape: const CircleBorder(),
                        color: Colors.white,
                        child: Icon(
                          CupertinoIcons.videocam_fill,
                          color: Theme.of(context).colorScheme.primary,
                          size: 28,
                        )),
                  ],
                ))
          ],
        ),
      );
    },
  );
}
