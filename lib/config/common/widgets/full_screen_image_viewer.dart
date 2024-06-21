import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

fullScreenImageViewer(BuildContext context, String url) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: false,
    useSafeArea: true,
    isDismissible: false,
    enableDrag: false,
    builder: (context) => Stack(
      children: [
        PhotoView(imageProvider: CachedNetworkImageProvider(url)),
        Positioned(
            top: 0,
            right: 0,
            child: CloseButton(
              color: Colors.white,
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(8),
                  backgroundColor: MaterialStateProperty.all(Colors.black)),
            )),
      ],
    ),
  );
}
