// ignore_for_file: library_private_types_in_public_api, avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:custom_info_window/custom_info_window.dart';
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

class NearByTemples extends StatefulWidget {
  const NearByTemples({Key? key}) : super(key: key);

  @override
  _NearByTemplesState createState() => _NearByTemplesState();
}

class _NearByTemplesState extends State<NearByTemples> {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 13.4746,
  );

  late final Set<Marker> _markers = {};
  late GoogleMapController _controller;
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  final List<dynamic> _contacts = [
    {
      "name": "Me",
      "position": const LatLng(37.42796133580664, -122.085749655962),
      "marker": 'assets/images/markers/marker-1.png',
      "image": 'assets/images/markers/marker-1.png',
    },
    {
      "name": "Samantha",
      "position": const LatLng(37.42484642575639, -122.08309359848501),
      "marker": 'assets/images/markers/marker-2.png',
      "image": 'assets/images/markers/marker-2.png',
    },
    {
      "name": "Malte",
      "position": const LatLng(37.42381625902441, -122.0928531512618),
      "marker": 'assets/images/markers/marker-3.png',
      "image": 'assets/images/markers/marker-3.png',
    },
    {
      "name": "Julia",
      "position": const LatLng(37.41994095849639, -122.08159055560827),
      "marker": 'assets/images/markers/marker-4.png',
      "image": 'assets/images/markers/marker-4.png',
    },
    {
      "name": "Tim",
      "position": const LatLng(37.413175077529935, -122.10101041942836),
      "marker": 'assets/images/markers/marker-5.png',
      "image": 'assets/images/markers/marker-5.png',
    },
    {
      "name": "Sara",
      "position": const LatLng(37.419013242401576, -122.11134664714336),
      "marker": 'assets/images/markers/marker-6.png',
      "image": 'assets/images/markers/marker-6.png',
    },
    {
      "name": "Ronaldo",
      "position": const LatLng(37.40260962243491, -122.0976958796382),
      "marker": 'assets/images/markers/marker-7.png',
      "image": 'assets/images/markers/marker-7.png',
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    createMarkers(context);

    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          initialCameraPosition: _kGooglePlex,
          myLocationButtonEnabled: false,
          mapType: MapType.normal,
          zoomControlsEnabled: true,
          markers: _markers,
          onCameraMove: (position) {
            _customInfoWindowController.onCameraMove!();
          },
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
            _customInfoWindowController.googleMapController = controller;
            controller.setMapStyle(mapThemes.first);
          },
        ),
        CustomInfoWindow(
          controller: _customInfoWindowController,
          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width * 0.8,
          offset: 60.0,
        ),
        //for list of near by temples
        Positioned(
          bottom: 35,
          left: 5,
          right: 55,
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _controller.moveCamera(
                          CameraUpdate.newLatLng(_contacts[index]["position"]));
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            _contacts[index]['image'],
                            width: 60,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            _contacts[index]["name"],
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )),
        ),
        //for map theme changing
        Positioned(
          bottom: 100,
          right: 15,
          child: Container(
              width: 35,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MaterialButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                            padding: const EdgeInsets.all(20),
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Select Theme",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 100,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: mapThemes.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            _controller.setMapStyle(
                                                mapThemes[index]['style']);
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            width: 100,
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      mapThemes[index]
                                                          ['image']),
                                                )),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            )),
                      );
                    },
                    padding: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.layers_rounded, size: 25),
                  ),
                ],
              )),
        )
      ],
    ));
  }

  createMarkers(BuildContext context) {
    Marker marker;

    _contacts.forEach((contact) async {
      marker = Marker(
          markerId: MarkerId(contact['name']),
          position: contact['position'],
          icon: await _getAssetIcon(context, contact['marker'])
              .then((value) => value),
          // infoWindow: InfoWindow(
          //   title: contact['name'],
          //   snippet: 'Street 6 . 2min ago',
          // ),
          onTap: () {
            _customInfoWindowController.addInfoWindow!(
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              'https://cdn.pixabay.com/photo/2024/03/02/08/07/ai-generated-8607806_640.jpg',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Arulmigu Vadapalani Murugan Temple",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MaterialButton(
                              onPressed: () {},
                              elevation: 0,
                              height: 20,
                              color: Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Temple Info",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            MaterialButton(
                              onPressed: () {},
                              elevation: 0,
                              height: 20,
                              color: Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Direction",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 5.0,
                    left: 5.0,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _customInfoWindowController.hideInfoWindow!();
                      },
                    ),
                  ),
                ],
              ),
              contact['position'],
            );
          });

      setState(() {
        _markers.add(marker);
      });
    });
  }

  Future<BitmapDescriptor> _getAssetIcon(
      BuildContext context, String icon) async {
    final Completer<BitmapDescriptor> bitmapIcon =
        Completer<BitmapDescriptor>();
    final ImageConfiguration config =
        createLocalImageConfiguration(context, size: const Size(5, 5));

    AssetImage(icon)
        .resolve(config)
        .addListener(ImageStreamListener((ImageInfo image, bool sync) async {
      final ByteData? bytes =
          await image.image.toByteData(format: ImageByteFormat.png);
      final BitmapDescriptor bitmap =
          BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
      bitmapIcon.complete(bitmap);
    }));

    return await bitmapIcon.future;
  }
}
