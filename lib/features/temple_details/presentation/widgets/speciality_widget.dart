import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:news_app_clean_architecture/config/common/extensions.dart';

import '../../../../config/common/widgets/app_header.dart';
import '../../../../config/common/widgets/full_screen_image_viewer.dart';
import '../../../../config/constants.dart';
import '../../domain/entities/speciality.dart';

class SpecialityWidget extends StatefulWidget {
  final List<SpecialityEntity> specialityList;
  const SpecialityWidget({Key? key, required this.specialityList})
      : super(key: key);

  @override
  State<SpecialityWidget> createState() => _SpecialityWidgetState();
}

class _SpecialityWidgetState extends State<SpecialityWidget> {
  final ValueNotifier<int> _showDetails = ValueNotifier(-1);
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        if (_showDetails.value != -1) {
          _showDetails.value = -1;
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: appHeader(
            leading: const BackButton(),
            context: context,
            body: LocaleText("speciality",
                textAlign: TextAlign.center,
                style: appbarTextStyleLarge(Theme.of(context))),
            trailing: 32.pw),
        body: ValueListenableBuilder<int>(
            valueListenable: _showDetails,
            builder: (context, selectedIndex, child) {
              if (selectedIndex != -1) {
                return _buildDetailsWidget(selectedIndex, context);
              }
              return ListView.builder(
                itemCount: widget.specialityList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _showDetails.value = index;
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                            height: 230,
                            width: double.infinity,
                            placeholder: (context, url) => const Padding(
                              padding: EdgeInsets.symmetric(vertical: 24),
                              child: CupertinoActivityIndicator(),
                            ),
                            imageUrl: widget.specialityList[index]
                                    .specialityImage!.isNotEmpty
                                ? ApiCredentials().documents +
                                    widget.specialityList[index]
                                        .specialityImage![0].fileLocation
                                        .toString()
                                : NetworkImages.templePlaceHolder,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, top: 8, bottom: 4),
                            child: Text(
                              widget.specialityList[index].specialityTitle ??
                                  "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: Row(
                              children: [
                                Icon(
                                  CupertinoIcons.sparkles,
                                  size: 18,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                5.pw,
                                Text(
                                  widget.specialityList[index].specialityDesc ??
                                      "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }

  SingleChildScrollView _buildDetailsWidget(
      int selectedIndex, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Text(
              widget.specialityList[selectedIndex].specialityTitle ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          CarouselSlider.builder(
            itemCount:
                widget.specialityList[selectedIndex].specialityImage!.length,
            itemBuilder: (context, index, realIndex) => GestureDetector(
              onTap: () {
                fullScreenImageViewer(
                  context,
                  widget.specialityList[selectedIndex].specialityImage!
                          .isNotEmpty
                      ? ApiCredentials().documents +
                          widget.specialityList[selectedIndex]
                              .specialityImage![index].fileLocation!
                              .toString()
                      : NetworkImages.templePlaceHolder,
                );
              },
              child: CachedNetworkImage(
                width: double.infinity,
                placeholder: (context, url) => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: CupertinoActivityIndicator(),
                ),
                imageUrl: widget.specialityList[selectedIndex].specialityImage!
                        .isNotEmpty
                    ? ApiCredentials().documents +
                        widget.specialityList[selectedIndex]
                            .specialityImage![index].fileLocation!
                            .toString()
                    : NetworkImages.templePlaceHolder,
                fit: BoxFit.cover,
                imageBuilder: (context, imageProvider) => ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.08),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover)),
                  ),
                ),
              ),
            ),
            options: CarouselOptions(
              height: 200,
              clipBehavior: Clip.antiAlias,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll:
                  widget.specialityList[selectedIndex].specialityImage!.length >
                          1
                      ? true
                      : false,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
            ),
          ),
          20.ph,
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.sparkles,
                      size: 18,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    5.pw,
                    Text(
                      "${widget.specialityList[selectedIndex].specialityDesc ?? ""}\n",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                15.ph,
                if (widget.specialityList[selectedIndex].specialityDetails !=
                        null &&
                    widget.specialityList[selectedIndex].specialityDetails!
                        .isNotEmpty)
                  LocaleText(
                    "details",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                5.ph,
                Text(
                  widget.specialityList[selectedIndex].specialityDetails ?? "",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
