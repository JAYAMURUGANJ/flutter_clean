import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/config/common/extensions.dart';
import 'package:news_app_clean_architecture/config/common/pages/error/something_went_wrong_screen.dart';
import 'package:news_app_clean_architecture/features/temple_details/domain/entities/shrines_details.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/bloc/shrines_details/shrines_bloc.dart';
import 'package:news_app_clean_architecture/features/temple_list/domain/entities/itms_response.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../../config/common/widgets/full_screen_image_viewer.dart';
import '../../../../config/constants.dart';

class ShrinesWidget extends StatefulWidget {
  final ItmsResponseEntity? templeData;
  const ShrinesWidget({Key? key, this.templeData}) : super(key: key);

  @override
  State<ShrinesWidget> createState() => _ShrinesWidgetState();
}

class _ShrinesWidgetState extends State<ShrinesWidget> {
  final CarouselController _carouselController = CarouselController();
  ValueNotifier<int> currentIndex = ValueNotifier(0);
  @override
  void initState() {
    BlocProvider.of<ShrinesBloc>(context)
        .add(GetShrinesEvent(templeId: widget.templeData!.templeId.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShrinesBloc, ShrinesState>(
      builder: (context, state) {
        if (state is ShrinesLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is ShrinesLodingError) {
          return ErrorWidget(state.error.toString());
        }
        if (state is ShrinesLoadingSomthingWentWrong) {
          return SomethingWentWrong(error: state.error.toString());
        }
        if (state is ShrinesLoaded) {
          List<ShrinesDetailsEntity> shrinesList =
              state.shrines!.cast<ShrinesDetailsEntity>();
          return Padding(
              padding: const EdgeInsets.all(12.0),
              child: shrinesList.isNotEmpty
                  ? SingleChildScrollView(
                      child: ValueListenableBuilder<int>(
                          valueListenable: currentIndex,
                          builder: (context, value, child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      currentIndex.value >= 1
                                          ? IconButton(
                                              onPressed: () {
                                                _carouselController
                                                    .previousPage();
                                              },
                                              icon: const Icon(
                                                  CupertinoIcons.back))
                                          : 0.pw,
                                      Flexible(
                                        child: Text(
                                          shrinesList[currentIndex.value]
                                                  .subshrineName ??
                                              "-",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                        ),
                                      ),
                                      (currentIndex.value <
                                              (shrinesList.length - 1))
                                          ? IconButton(
                                              onPressed: () {
                                                _carouselController.nextPage();
                                              },
                                              icon: const Icon(
                                                  CupertinoIcons.forward))
                                          : 0.pw,
                                    ],
                                  ),
                                ),
                                CarouselSlider.builder(
                                  carouselController: _carouselController,
                                  options: CarouselOptions(
                                    onPageChanged: (index, reason) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        currentIndex.value = index;
                                      });
                                    },
                                    height: 220,
                                    aspectRatio: 16 / 9,
                                    viewportFraction: 0.8,
                                    initialPage: 0,
                                    enableInfiniteScroll: false,
                                    reverse: false,
                                    autoPlay: false,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    enlargeFactor: 0.3,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                  itemCount: shrinesList.length,
                                  itemBuilder: (context, index, realIndex) {
                                    return GestureDetector(
                                      onTap: () {
                                        fullScreenImageViewer(
                                          context,
                                          ApiCredentials().documents +
                                              shrinesList[index]
                                                  .subshrineImage![0]
                                                  .fileLocation!,
                                        );
                                      },
                                      child: CachedNetworkImage(
                                        width: double.infinity,
                                        imageUrl: shrinesList[index]
                                                .subshrineImage!
                                                .isNotEmpty
                                            ? ApiCredentials().documents +
                                                shrinesList[index]
                                                    .subshrineImage![0]
                                                    .fileLocation!
                                            : NetworkImages.templePlaceHolder,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                ClipRRect(
                                          clipBehavior: Clip.antiAlias,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.black
                                                    .withOpacity(0.08),
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  child: Text(
                                    "Speciality : ${shrinesList[currentIndex.value].specialityDesc ?? "-"}",
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    shrinesList[currentIndex.value]
                                            .subshrineDesc ??
                                        "-",
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            );
                          }),
                    )
                  : const Text("no data available")

              // MasonryGridView.count(
              //   itemCount: shrinesList.length,
              //   crossAxisCount: 2,
              //   mainAxisSpacing: 16,
              //   crossAxisSpacing: 16,
              //   itemBuilder: (context, index) {
              //     return
              //     Container(
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(16.0),
              //       ),
              //       clipBehavior: Clip.antiAlias,
              //       child: CachedNetworkImage(
              //         // imageUrl: temple!.maintowerImage![0].fileLocation.toString(),
              //         imageUrl: shrinesList[index].subshrineImage!.isNotEmpty
              //             ? 'https://hrce.tn.gov.in/webservice/documentview.php?file_path=${shrinesList[index].subshrineImage![0].fileLocation}'
              //             : NetworkImages.templePlaceHolder,
              //       ),
              //     );
              //   },
              // ),
              );
        }
        return 0.pw;
      },
    );
  }
}
