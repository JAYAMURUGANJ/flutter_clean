import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../../../temple_list/domain/entities/itms_response.dart';
import '/config/common/extensions.dart';
import '/config/common/pages/error/something_went_wrong_screen.dart';
import '/config/common/widgets/app_header.dart';
import '/config/common/widgets/full_screen_image_viewer.dart';
import '/config/constants.dart';
import '/features/temple_details/domain/entities/facility.dart';
import '/features/temple_details/presentation/bloc/facility/facility_bloc.dart';

class FacilityWidget extends StatefulWidget {
  final ItmsResponseEntity? templeData;
  const FacilityWidget({Key? key, this.templeData}) : super(key: key);

  @override
  State<FacilityWidget> createState() => _FacilityWidgetState();
}

class _FacilityWidgetState extends State<FacilityWidget> {
  final ValueNotifier<int> _showDesc = ValueNotifier(-1);
  @override
  void initState() {
    BlocProvider.of<FacilityBloc>(context).add(
        GetFacilityEvent(templeId: widget.templeData!.templeId.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        if (_showDesc.value != -1) {
          _showDesc.value = -1;
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: appHeader(
            leading: const BackButton(),
            context: context,
            body: LocaleText("facility",
                textAlign: TextAlign.center,
                style: appbarTextStyleLarge(Theme.of(context))),
            trailing: 32.pw),
        body: BlocBuilder<FacilityBloc, FacilityState>(
          builder: (context, state) {
            if (state is FacilityLoading) {
              return const Center(child: CupertinoActivityIndicator());
            }
            if (state is FacilityLoadingError) {
              return ErrorWidget(state.error.toString());
            }
            if (state is FacilityLoadingSomthingWentWrong) {
              return SomethingWentWrong(error: state.responseStatus.toString());
            }
            if (state is FacilityLoaded) {
              List<FacilityEntity> facilityList =
                  state.facility!.cast<FacilityEntity>();
              return ValueListenableBuilder<int>(
                  valueListenable: _showDesc,
                  builder: (context, selectedIndex, child) {
                    if (selectedIndex != -1) {
                      return _buildDescWidget(facilityList[selectedIndex]);
                    }
                    return ListView.builder(
                      itemCount: facilityList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              _showDesc.value = index;
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              height: 280,
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
                                children: [
                                  CachedNetworkImage(
                                    height: 230,
                                    width: double.infinity,
                                    placeholder: (context, url) =>
                                        const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 24),
                                      child: CupertinoActivityIndicator(),
                                    ),
                                    imageUrl: facilityList[index]
                                            .facilityImage!
                                            .isNotEmpty
                                        ? ApiCredentials().documents +
                                            facilityList[index]
                                                .facilityImage![0]
                                                .fileLocation
                                                .toString()
                                        : NetworkImages.templePlaceHolder,
                                    fit: BoxFit.cover,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 12, top: 8, bottom: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            facilityList[index].facilityTitle ??
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
                                        CircleAvatar(
                                          radius: 14,
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          child: Text(
                                            facilityList[index]
                                                    .noofFacilities ??
                                                "",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  });
            }
            return 0.pw;
          },
        ),
      ),
    );
  }

  _buildDescWidget(FacilityEntity facilityList) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Text(
              facilityList.facilityTitle ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          CarouselSlider.builder(
            itemCount: facilityList.facilityImage!.length,
            itemBuilder: (context, index, realIndex) => GestureDetector(
              onTap: () {
                fullScreenImageViewer(
                  context,
                  facilityList.facilityImage!.isNotEmpty
                      ? ApiCredentials().documents +
                          facilityList.facilityImage![index].fileLocation!
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
                imageUrl: facilityList.facilityImage!.isNotEmpty
                    ? ApiCredentials().documents +
                        facilityList.facilityImage![index].fileLocation!
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
                  facilityList.facilityImage!.length > 1 ? true : false,
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
                    LocaleText("available",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary)),
                    Text(" : ${facilityList.noofFacilities}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
                10.ph,
                LocaleText(
                  "description",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                  textAlign: TextAlign.left,
                ),
                5.ph,
                Text(
                  facilityList.facilityDesc ?? "",
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
