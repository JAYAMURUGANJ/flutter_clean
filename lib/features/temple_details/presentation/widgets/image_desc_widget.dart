import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../../config/common/widgets/full_screen_image_viewer.dart';

class ImageDescWidget extends StatefulWidget {
  final PageController pageController;
  final String imageUrl;
  final String? name;
  final String? desc;
  final int length;
  const ImageDescWidget(
      {Key? key,
      required this.pageController,
      required this.imageUrl,
      this.name,
      this.desc,
      required this.length})
      : super(key: key);

  @override
  State<ImageDescWidget> createState() => _ImageDescWidgetState();
}

class _ImageDescWidgetState extends State<ImageDescWidget> {
  final ScrollController _mainScrollController = ScrollController();
  final ScrollController _descriptionScrollController = ScrollController();
  final ValueNotifier<bool> _scrollDesc = ValueNotifier(false);

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
          _descriptionScrollController.offset <= 0.0) {
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
    return Stack(
      children: [
        CachedNetworkImage(
          width: double.infinity,
          height: double.infinity,
          imageUrl: widget.imageUrl,
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
        NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _mainScrollListener();
              });
              return true;
            },
            child: SingleChildScrollView(
              controller: _mainScrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          height: 50,
                          thickness: 6,
                          color: Theme.of(context).colorScheme.primary,
                          endIndent: MediaQuery.of(context).size.width * .35,
                        ),
                        ValueListenableBuilder(
                            valueListenable: _scrollDesc,
                            builder: (context, value, child) {
                              return SizedBox(
                                height: MediaQuery.of(context).size.height / 2,
                                child: SingleChildScrollView(
                                  controller: _descriptionScrollController,
                                  physics: _scrollDesc.value
                                      ? const AlwaysScrollableScrollPhysics()
                                      : const NeverScrollableScrollPhysics(),
                                  child: Text(
                                    widget.desc ?? "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400),
                                  ),
                                ),
                              );
                            })
                      ],
                    ),
                  ),
                ],
              ),
            )),
        // navigation button
        if (widget.length > 1)
          Positioned(
              top: 15,
              right: 10,
              child: Row(
                children: [
                  MaterialButton(
                    minWidth: 1,
                    color: Colors.white,
                    shape: const CircleBorder(),
                    onPressed: () {
                      widget.pageController.previousPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut);
                    },
                    child: const Icon(
                      CupertinoIcons.back,
                      size: 24,
                    ),
                  ),
                  MaterialButton(
                    minWidth: 1,
                    color: Colors.white,
                    shape: const CircleBorder(),
                    onPressed: () {
                      widget.pageController.nextPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut);
                    },
                    child: const Icon(
                      CupertinoIcons.forward,
                      size: 24,
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
      ],
    );
  }
}
