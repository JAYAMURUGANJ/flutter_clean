import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildImage(BuildContext context, String url,
    {double? width, double? height}) {
  return CachedNetworkImage(
    // imageUrl: temple!.maintowerImage![0].fileLocation.toString(),
    imageUrl: url,
    imageBuilder: (context, imageProvider) => ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
      child: Container(
        width: width ?? MediaQuery.of(context).size.width / 3,
        height: height ?? double.maxFinite,
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.08),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
      ),
    ),
    progressIndicatorBuilder: (context, url, downloadProgress) => ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
      child: Container(
        width: width ?? MediaQuery.of(context).size.width / 3,
        height: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.08),
        ),
        child: const CupertinoActivityIndicator(),
      ),
    ),
    errorWidget: (context, url, error) => ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
      child: Container(
        width: width ?? MediaQuery.of(context).size.width / 3,
        height: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.08),
        ),
        child: const Icon(Icons.error),
      ),
    ),
  );
}
