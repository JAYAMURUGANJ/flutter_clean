import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../config/constants.dart';

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

class TempleMapLocation extends StatefulWidget {
  const TempleMapLocation({Key? key}) : super(key: key);
  @override
  State<TempleMapLocation> createState() => TempleMapLocationState();
}

class TempleMapLocationState extends State<TempleMapLocation> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(12.9815, 80.2180), zoom: 13);

  static const CameraPosition temple = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(12.9815, 80.2180),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  Future<void> _goToTheTemple() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(temple));
  }

  Future<void> addCustomIcon() async {
    final Uint8List markerIconByte =
        await getBytesFromAsset(LocalImages().mapMarker, 100);
    setState(() {
      markerIcon = BitmapDescriptor.fromBytes(markerIconByte);
    });
  }

  @override
  void initState() {
    super.initState();
    addCustomIcon();
    _goToTheTemple();
  }

  @override
  build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        tiltGesturesEnabled: true,
        scrollGesturesEnabled: true,
        markers: {
          Marker(
            markerId: const MarkerId("101"),
            position: _kGooglePlex.target,
            icon: markerIcon,
          )
        },
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}


// floatingActionButton: FloatingActionButton.extended(
//         onPressed: _goToTheTemple,
//         label: const Text('Reload'),
//         icon: const Icon(Icons.refresh_outlined),
//       ),