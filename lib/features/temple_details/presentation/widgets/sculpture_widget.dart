import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/config/common/extensions.dart';
import 'package:news_app_clean_architecture/features/temple_details/domain/entities/sculpture.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/bloc/sculptures/sculptures_bloc.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/bloc/view_desc/view_desc_bloc.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/widgets/image_desc_widget.dart';
import 'package:news_app_clean_architecture/features/temple_list/domain/entities/itms_response.dart';

import '../../../../config/common/pages/error/something_went_wrong_screen.dart';
import '../../../../config/constants.dart';

class SculpturesWidget extends StatefulWidget {
  final ItmsResponseEntity? templeData;
  const SculpturesWidget({Key? key, this.templeData}) : super(key: key);

  @override
  State<SculpturesWidget> createState() => _SculpturesWidgetState();
}

class _SculpturesWidgetState extends State<SculpturesWidget> {
  final PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  @override
  void initState() {
    BlocProvider.of<SculpturesBloc>(context).add(
        GetSculpturesEvent(templeId: widget.templeData!.templeId.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (BlocProvider.of<ViewDescBloc>(context).state is ShowViewDesc) {
            BlocProvider.of<ViewDescBloc>(context).add(CloseDesc());
          } else {
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<ViewDescBloc, ViewDescState>(
            builder: (context, viewDesc) {
          if (viewDesc is ShowViewDesc) {
            return _buildDescWidget(context, viewDesc);
          }
          return BlocBuilder<SculpturesBloc, SculpturesState>(
              builder: (context, state) {
            if (state is SculpturesLoading) {
              return const Center(child: CupertinoActivityIndicator());
            }
            if (state is SculpturesLoadingError) {
              return ErrorWidget(state.error.toString());
            }
            if (state is SculpturesLoadingSomthingWentWrong) {
              return SomethingWentWrong(error: state.responseStatus.toString());
            }
            if (state is SculpturesLoaded) {
              List<SculptureEntity> sculpturesList =
                  state.sculptures!.cast<SculptureEntity>();
              return PageView.builder(
                  controller: _pageController,
                  itemCount: sculpturesList.length,
                  itemBuilder: (context, index) {
                    return ImageDescWidget(
                      pageController: _pageController,
                      imageUrl: sculpturesList[index].sculptureInfo!.isNotEmpty
                          ? ApiCredentials().documents +
                              sculpturesList[index]
                                  .sculptureInfo![0]
                                  .fileLocation!
                          : NetworkImages.templePlaceHolder,
                      name: sculpturesList[index].sculpturesName ?? "",
                      desc: sculpturesList[index].sculptureDesc ?? "",
                      length: sculpturesList.length,
                    );

                    //
                  });
            }
            return 0.pw;
          });
        }));
  }

  Padding _buildDescWidget(BuildContext context, ShowViewDesc viewDesc) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<ViewDescBloc>(context).add(CloseDesc());
                    },
                    icon: const Icon(CupertinoIcons.back)),
                Text(
                  viewDesc.sculpture.sculpturesName ?? "-",
                ),
              ],
            ),
            CachedNetworkImage(
              height: 200,
              // width: double.infinity,
              placeholder: (context, url) => const CupertinoActivityIndicator(),
              imageUrl: viewDesc.sculpture.sculptureInfo!.isNotEmpty
                  ? ApiCredentials().documents +
                      viewDesc.sculpture.sculptureInfo![0].fileLocation!
                  : NetworkImages.templePlaceHolder,
              imageBuilder: (context, imageProvider) => ClipRRect(
                clipBehavior: Clip.antiAlias,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black.withOpacity(0.08),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.fitHeight)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                viewDesc.sculpture.sculptureDesc ?? "-",
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
