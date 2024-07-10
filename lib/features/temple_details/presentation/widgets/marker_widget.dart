import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:news_app_clean_architecture/config/constants.dart';

Future<Marker> createMarkerWithCustomIcon(String imageUrl, LatLng position,
    String markerTitle, Function()? onTap) async {
  final BitmapDescriptor customIcon =
      await getMarkerIcon(imageUrl, const Size(200, 200));

  final Marker marker = Marker(
    markerId: MarkerId(markerTitle),
    position: position,
    icon: customIcon,
    onTap: onTap,
  );

  return marker;
}

Future getMarkerIcon(String imageUrl, Size size) async {
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  const double shadowWidth = 15.0;
  const double borderWidth = 3.0;
  const double imageOffset = shadowWidth + borderWidth;

//=========>
  ui.Image? images;
  final ByteData bytes = await rootBundle.load(LocalImages().mapMarker);
  images = await decodeImageFromList(bytes.buffer.asUint8List());

  Paint greenBrush = Paint()..color = Colors.greenAccent;
  canvas.save();
  canvas.drawImage(images, const Offset(0, 0), greenBrush);
  canvas.restore();

// Oval for the image
  Rect oval = Rect.fromLTWH(imageOffset + 2, 10, size.width - (imageOffset * 5),
      size.height - (imageOffset * 5));

// Clip oval path for image
  canvas.clipPath(Path()..addOval(oval));

  // Fetch and draw the network image
  ui.Image image = await _fetchNetworkImage(imageUrl);
  paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.cover);

// Convert canvas to image
  final ui.Image markerAsImage = await pictureRecorder
      .endRecording()
      .toImage(size.width.toInt(), size.height.toInt());

// Convert image to bytes
  final ByteData? byteData =
      await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
  final Uint8List uint8List = byteData!.buffer.asUint8List();

  // ignore: deprecated_member_use
  return BitmapDescriptor.fromBytes(uint8List);
}

Future<ui.Image> _fetchNetworkImage(String imageUrl) async {
  //
  Uint8List imageBytes =
      (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl))
          .buffer
          .asUint8List();
  final ui.Codec codec = await ui.instantiateImageCodec(imageBytes);
  final ui.FrameInfo fi = await codec.getNextFrame();
  return fi.image;
}
