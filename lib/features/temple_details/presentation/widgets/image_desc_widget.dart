import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../../../../config/common/class/text_fade_up_animation.dart';
import '../../../../config/common/class/text_slide_animation_widget.dart';
import '../../../../config/common/widgets/full_screen_image_viewer.dart';

class ImageDescPageViewer extends StatefulWidget {
  final PageController pageController;
  final String imageUrl;
  final String? name;
  final String? desc;
  final int length;
  final int index;
  const ImageDescPageViewer({
    Key? key,
    required this.pageController,
    required this.imageUrl,
    this.name,
    this.desc,
    required this.length,
    required this.index,
  }) : super(key: key);

  @override
  State<ImageDescPageViewer> createState() => _ImageDescPageViewerState();
}

class _ImageDescPageViewerState extends State<ImageDescPageViewer>
    with SingleTickerProviderStateMixin {
  final ScrollController _mainScrollController = ScrollController();
  final ScrollController _descriptionScrollController = ScrollController();
  final ValueNotifier<bool> _scrollDesc = ValueNotifier(false);
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _mainScrollController.addListener(_mainScrollListener);
    });
  }

  void _mainScrollListener() {
    if (_mainScrollController.offset >=
        MediaQuery.of(context).size.height * .19) {
      if (_descriptionScrollController.position.userScrollDirection ==
              ScrollDirection.forward &&
          _descriptionScrollController.offset <= 0.00) {
        _scrollDesc.value = false;
      } else {
        _scrollDesc.value = true;
      }
    } else {
      _scrollDesc.value = false;
    }
  }

  @override
  void dispose() {
    _mainScrollController.removeListener(_mainScrollListener);
    _mainScrollController.dispose();
    _descriptionScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: _scrollDesc,
        builder: (context, scrollDescValue, child) {
          return Stack(
            children: [
              CachedNetworkImage(
                width: double.infinity,
                height: double.infinity,
                imageUrl: widget.imageUrl,
                errorWidget: (context, url, error) {
                  return errorImageWidget(size: 120);
                },
                imageBuilder: (context, imageProvider) => ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    )),
                  ),
                ),
              ),
              // navigation button
              if (widget.length > 1)
                Positioned(
                    top: 15,
                    right: 10,
                    child: Row(
                      children: [
                        MaterialButton(
                          minWidth: 1,
                          elevation: widget.index <= 0 ? 0 : 8,
                          color: Colors.white,
                          shape: const CircleBorder(),
                          onPressed: () {
                            widget.index <= 0
                                ? null
                                : widget.pageController.previousPage(
                                    duration: const Duration(milliseconds: 250),
                                    curve: Curves.easeInOut);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: widget.index <= 0 ? 20 : 24,
                            color:
                                widget.index <= 0 ? Colors.grey : Colors.black,
                          ),
                        ),
                        MaterialButton(
                          minWidth: 1,
                          elevation:
                              widget.index == (widget.length - 1) ? 0 : 8,
                          color: Colors.white,
                          shape: const CircleBorder(),
                          onPressed: () {
                            widget.index == (widget.length - 1)
                                ? null
                                : widget.pageController.nextPage(
                                    duration: const Duration(milliseconds: 250),
                                    curve: Curves.easeInOut);
                          },
                          child: Icon(
                            Icons.arrow_forward,
                            size: widget.index == (widget.length - 1) ? 20 : 24,
                            color: widget.index == (widget.length - 1)
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                      ],
                    )),
              Positioned(
                left: 0,
                top: 15,
                child: MaterialButton(
                  color: Colors.white,
                  shape: const CircleBorder(),
                  onPressed: () {
                    fullScreenImageViewer(
                      context,
                      widget.imageUrl,
                    );
                  },
                  child: const Icon(
                    Icons.filter_center_focus_outlined,
                    size: 20,
                  ),
                ),
              ),
              // content
              DraggableScrollableSheet(
                  initialChildSize: .5,
                  minChildSize: .5,
                  maxChildSize: .8,
                  controller: _sheetController,
                  shouldCloseOnMinExtent: false,
                  builder: ((ctx, ScrollController scrollController) {
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: Container(
                          constraints: BoxConstraints(
                              minHeight:
                                  MediaQuery.of(context).size.height * .81),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 24.0),
                          decoration: const BoxDecoration(
                            color: Colors.black87,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: TextSlideAnimationWidget(
                                  text: widget.name ?? "",
                                  textColor: Colors.white,
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                              Divider(
                                height: 50,
                                thickness: 6,
                                color: Theme.of(context).colorScheme.primary,
                                endIndent:
                                    MediaQuery.of(context).size.width * .35,
                              ),
                              TextFadeUpAnimationWidget(
                                text: widget.desc ?? "",
                              ),
                              // Text(
                              //   widget.desc ?? "",
                              //   style: Theme.of(context)
                              //       .textTheme
                              //       .titleMedium!
                              //       .copyWith(
                              //           color: Colors.white,
                              //           fontWeight: FontWeight.w400),
                              // ),
                            ],
                          )),
                    );
                  })),
            ],
          );
        });
  }

  Padding errorImageWidget({required double size}) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_not_supported_outlined,
            size: size,
          ),
          const LocaleText("No Image Found !"),
        ],
      ),
    );
  }
}
