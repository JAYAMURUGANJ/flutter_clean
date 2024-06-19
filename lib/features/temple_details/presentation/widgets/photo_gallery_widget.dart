import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:news_app_clean_architecture/config/common/extensions.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/bloc/photo_gallery_desc/photo_gallery_desc_cubit.dart';

import '../../../../config/common/pages/error/something_went_wrong_screen.dart';
import '../../../../config/common/widgets/app_header.dart';
import '../../../../config/common/widgets/full_screen_image_viewer.dart';
import '../../../../config/constants.dart';
import '../../../temple_list/domain/entities/itms_response.dart';
import '../../domain/entities/photo_gallery.dart';
import '../bloc/photo_gallery/photo_gallery_bloc.dart';

class PhotoGalleryWidget extends StatefulWidget {
  final ItmsResponseEntity templeData;
  const PhotoGalleryWidget({Key? key, required this.templeData})
      : super(key: key);

  @override
  State<PhotoGalleryWidget> createState() => _PhotoGalleryWidgetState();
}

class _PhotoGalleryWidgetState extends State<PhotoGalleryWidget> {
  @override
  void initState() {
    BlocProvider.of<PhotoGalleryDescCubit>(context).closePhotoGalleryDesc();
    BlocProvider.of<PhotoGalleryBloc>(context)
        .add(GetPhotoGallery(templeId: widget.templeData.templeId.toString()));
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
        if (BlocProvider.of<PhotoGalleryDescCubit>(context).state
            is PhotoGalleryDescLoaded) {
          BlocProvider.of<PhotoGalleryDescCubit>(context)
              .closePhotoGalleryDesc();
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        appBar: appHeader(
            leading: const BackButton(),
            context: context,
            body: LocaleText("photo_gallery",
                textAlign: TextAlign.center,
                style: appbarTextStyleLarge(Theme.of(context))),
            trailing: 32.pw),
        body: BlocBuilder<PhotoGalleryDescCubit, PhotoGalleryDescState>(
          builder: (context, descState) {
            if (descState is PhotoGalleryDescLoaded) {
              return _buildDescWidget(descState.photoGalleryDesc);
            }
            return BlocBuilder<PhotoGalleryBloc, PhotoGalleryState>(
              builder: (context, state) {
                if (state is PhotoGalleryLoading) {
                  return const Center(child: CupertinoActivityIndicator());
                }
                if (state is PhotoGalleryLoadingError) {
                  return ErrorWidget(state.error.toString());
                }
                if (state is PhotoGalleryLoadingSomthingWentWrong) {
                  return SomethingWentWrong(
                      error: state.responseStatus.toString());
                }
                if (state is PhotoGalleryLoaded) {
                  List<PhotoGalleryEntity> photoGalleryList =
                      state.photoGallery!.cast<PhotoGalleryEntity>();
                  return MasonryGridView.count(
                    padding: const EdgeInsets.all(18),
                    crossAxisCount: 2,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 24,
                    itemCount: photoGalleryList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<PhotoGalleryDescCubit>(context)
                                  .viewPhotoGalleryDesc(
                                      photoGalleryList[index]);
                            },
                            child: ClipRRect(
                              clipBehavior: Clip.antiAlias,
                              borderRadius: BorderRadius.circular(16),
                              child: CachedNetworkImage(
                                placeholder: (context, url) => const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 24),
                                  child: CupertinoActivityIndicator(),
                                ),
                                imageUrl: photoGalleryList[index]
                                        .photoInfo!
                                        .isNotEmpty
                                    ? ApiCredentials().documents +
                                        photoGalleryList[index]
                                            .photoInfo![0]
                                            .fileLocation
                                            .toString()
                                    : NetworkImages.templePlaceHolder,
                                fit: BoxFit.cover,
                                imageBuilder: (context, imageProvider) =>
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 8),
                            child: Text(
                              photoGalleryList[index].title ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
                return 0.pw;
              },
            );
          },
        ),
      ),
    );
  }

  _buildDescWidget(PhotoGalleryEntity photoData) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Text(
              photoData.title ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          CarouselSlider.builder(
              itemCount: photoData.photoInfo!.length,
              itemBuilder: (context, index, realIndex) => GestureDetector(
                    onTap: () {
                      fullScreenImageViewer(
                        context,
                        photoData.photoInfo!.isNotEmpty
                            ? ApiCredentials().documents +
                                photoData.photoInfo![index].fileLocation
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
                      imageUrl: photoData.photoInfo!.isNotEmpty
                          ? ApiCredentials().documents +
                              photoData.photoInfo![index].fileLocation
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
                    photoData.photoInfo!.length > 1 ? true : false,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              )),
          20.ph,
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  photoData.galleryDesc ?? "",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                  textAlign: TextAlign.left,
                ),
                15.ph,
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_outlined,
                      size: 18,
                    ),
                    const Text(" : "),
                    Text(
                      photoData.eventDate.indianDateFormat,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                15.ph,
                if (photoData.description != null &&
                    photoData.description!.isNotEmpty)
                  LocaleText(
                    "description",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                    textAlign: TextAlign.left,
                  ),
                5.ph,
                Text(
                  photoData.description ?? "",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
