import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

fullScreenImageViewer(BuildContext context, String url) {
  return showImageViewer(context, CachedNetworkImageProvider(url),
      swipeDismissible: true, doubleTapZoomable: true);
}
