// ignore_for_file: library_private_types_in_public_api, avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:map_launcher/map_launcher.dart' as mapLauncher;
import 'package:news_app_clean_architecture/features/temple_list/domain/entities/itms_response.dart';

import '/config/constants.dart';
import '../../../temple_list/presentation/bloc/itms/itms_bloc.dart';
import '../bloc/show_nearby_temples/show_nearby_temples_bloc.dart';

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

class NearByTemplesWidget extends StatefulWidget {
  final ItmsResponseEntity? temple;
  final Map<String, dynamic>? currentLocationData;
  const NearByTemplesWidget({
    Key? key,
    this.temple,
    this.currentLocationData,
  }) : super(key: key);

  @override
  _NearByTemplesWidgetState createState() => _NearByTemplesWidgetState();
}

class _NearByTemplesWidgetState extends State<NearByTemplesWidget> {
  CameraPosition? _kGooglePlex;
  late GoogleMapController _controller;
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  List<ItmsResponseEntity> listOfTemples = [];

  int selectedIndex = 0;

  @override
  void initState() {
    listOfTemples = BlocProvider.of<ITMSBloc>(context).state.templeList
        as List<ItmsResponseEntity>;
    _kGooglePlex = const CameraPosition(
      target: LatLng(37.4220936, -122.083922),
      zoom: 13.4746,
    );

    if (widget.temple != null) {
      double templeLat = double.parse(widget.temple!.templeLatitude!);
      double templeLang = double.parse(widget.temple!.templeLangitude!);

      _kGooglePlex = CameraPosition(
        target: LatLng(templeLat, templeLang),
        zoom: 13.4746,
      );
      BlocProvider.of<ShowNearbyTemplesBloc>(context).add(
          ViewSingleTempleEvent(widget.temple!, _customInfoWindowController));
    } else if (widget.currentLocationData!['current_location'] != null) {
      _kGooglePlex = CameraPosition(
        target: LatLng(
            widget.currentLocationData!['current_location'].latitude!,
            widget.currentLocationData!['current_location'].longitude!),
        // target: LatLng(13.00221616590524, 80.26871147262695),
        zoom: 13.4746,
      );

      BlocProvider.of<ShowNearbyTemplesBloc>(context).add(
          ViewCurrentLocationEvent(
              fromCurrentLocation: true,
              currentLocationLatLng: LatLng(
                  widget.currentLocationData!['current_location'].latitude!,
                  widget.currentLocationData!['current_location'].longitude!),
              listOfTemples: listOfTemples,
              customInfoWindowController: _customInfoWindowController,
              distance: widget.currentLocationData!['distance']));
    }
    super.initState();
  }

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: DropdownMenu(
          width: 90,
          inputDecorationTheme:
              const InputDecorationTheme(fillColor: Colors.white, filled: true),
          dropdownMenuEntries: List.generate(
              distanceList.length,
              (index) => DropdownMenuEntry(
                  value: distanceList[index],
                  label: distanceList[index].round().toString())),
          onSelected: (double? selectedValue) {
            // zoom level
            double zoomLevel = selectedValue ?? 5.0;
            double reduceValue = (zoomLevel / 5) - 1;
            zoomLevel = 13.0 - (reduceValue > 3 ? (3 + .3) : reduceValue);
            // animate zoom
            _controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(target: _kGooglePlex!.target, zoom: zoomLevel)));
            if (widget.currentLocationData!['current_location'] != null) {
              BlocProvider.of<ShowNearbyTemplesBloc>(context).add(
                  ViewCurrentLocationEvent(
                      fromCurrentLocation: true,
                      currentLocationLatLng: LatLng(
                          widget.currentLocationData!['current_location']
                              .latitude!,
                          widget.currentLocationData!['current_location']
                              .longitude!),
                      listOfTemples: listOfTemples,
                      customInfoWindowController: _customInfoWindowController,
                      distance: selectedValue ?? 5.0));
            } else {
              BlocProvider.of<ShowNearbyTemplesBloc>(context).add(
                  ViewNearByTemplesEvent(
                      fromCurrentLocation: false,
                      currentTemple: widget.temple,
                      listOfTemples: listOfTemples,
                      customInfoWindowController: _customInfoWindowController,
                      distance: selectedValue ?? 5.0));
            }
          },
        ),
        body: BlocConsumer<ShowNearbyTemplesBloc, ShowNearbyTemplesState>(
          listener: (context, markerState) {
            // if (markerState is ViewSingleTempleState) {
            //   _controller.animateCamera(CameraUpdate.newCameraPosition(
            //     markerState.cameraPosition!,
            //   ));
            // }
          },
          builder: (context, markerState) {
            // if (markerState is ViewNearbyTemplesLoading) {
            //   return const Center(
            //     child: CupertinoActivityIndicator(),
            //   );
            // }
            // if (markerState is ShowMarkerSWWState) {
            //   return const SomethingWentWrong(error: "error");
            // }
            // if (markerState is ViewSingleTempleState) {
            // _controller.animateCamera(CameraUpdate.newCameraPosition(
            //   markerState.cameraPosition!,
            // ));
            // }

            // if (markerState is ViewSingleTempleState) {
            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: _kGooglePlex!,
                  //  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  zoomControlsEnabled: true,
                  markers: markerState is ViewMarkersState
                      ? markerState.markers
                      : {},
                  onCameraMove: (position) {
                    _customInfoWindowController.onCameraMove!();
                  },
                  onMapCreated: (GoogleMapController controller) {
                    _controller = controller;
                    _customInfoWindowController.googleMapController =
                        controller;
                    _controller.setMapStyle(mapThemes.first['style']);
                  },
                ),
                CustomInfoWindow(
                  controller: _customInfoWindowController,
                  height: 240,
                  width: 280,
                  offset: 60.0,
                ),
                //for list of near by temples
                Positioned(
                  bottom: 35,
                  left: 5,
                  right: 55,
                  child: BlocBuilder<ShowNearbyTemplesBloc,
                      ShowNearbyTemplesState>(
                    builder: (context, nearbyState) {
                      if (nearbyState is ViewMarkersState &&
                          nearbyState.filteredTemples != null &&
                          nearbyState.markers.length > 1) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 120,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: nearbyState.markers.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    _controller.moveCamera(
                                        CameraUpdate.newLatLng(LatLng(
                                            double.parse(nearbyState
                                                .filteredTemples![index]
                                                .templeLatitude!),
                                            double.parse(nearbyState
                                                .filteredTemples![index]
                                                .templeLangitude!))));
                                    _controller.animateCamera(
                                        CameraUpdate.newCameraPosition(
                                            CameraPosition(
                                                target: LatLng(
                                                    double.parse(nearbyState
                                                        .filteredTemples![index]
                                                        .templeLatitude!),
                                                    double.parse(nearbyState
                                                        .filteredTemples![index]
                                                        .templeLangitude!)),
                                                zoom: 13)));
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    margin: const EdgeInsets.only(right: 10),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 24),
                                      child: Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          Positioned(
                                              child: Image.asset(
                                                  "assets/images/markers/marker-1.png")),
                                          Positioned(
                                            top: 6,
                                            child: SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: ClipOval(
                                                  clipBehavior:
                                                      ui.Clip.antiAlias,
                                                  child: CachedNetworkImage(
                                                    imageUrl: nearbyState
                                                            .filteredTemples![
                                                                index]
                                                            .maintowerImage!
                                                            .isNotEmpty
                                                        ? 'https://hrce.tn.gov.in/webservice/documentview.php?file_path=${nearbyState.filteredTemples![index].maintowerImage![0].fileLocation}'
                                                        : NetworkImages
                                                            .templePlaceHolder,
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        ClipRRect(
                                                      child: DecoratedBox(
                                                        decoration: BoxDecoration(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.08),
                                                            image: DecorationImage(
                                                                image:
                                                                    imageProvider,
                                                                fit: BoxFit
                                                                    .cover)),
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ));
                      }
                      ;
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                //for map theme changing
                Positioned(
                  bottom: 100,
                  right: 15,
                  child: Container(
                      width: 35,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
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
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                    selectedIndex = index;
                                                    _controller.setMapStyle(
                                                        mapThemes[index]
                                                            ['style']);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    width: 100,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    decoration: BoxDecoration(
                                                        border: selectedIndex ==
                                                                index
                                                            ? Border.all(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary,
                                                                width: 4.0,
                                                                strokeAlign:
                                                                    BorderSide
                                                                        .strokeAlignInside)
                                                            : Border.all(
                                                                width: 0.0),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
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
            );
            // }
          },
        ));
  }
//

  //

  // createMarkers(BuildContext context) {
  //   Marker marker;

  //   markerItem = Iterable.generate(listOfTemples.length, (index) {
  //     return marker = Marker(
  //       markerId: MarkerId(listOfTemples[index].templeId.toString()),
  //       position: LatLng(
  //           double.parse(listOfTemples[index].templeLatitude.toString()),
  //           double.parse(listOfTemples[index].templeLangitude.toString())),
  //     );
  //   });

  //   setState(() {
  //     _markers = Set.from(markerItem);
  //   });

  //   /// ====  single
  //   _contacts.forEach((contact) async {
  //     marker = await createMarkerWithCustomIcon(
  //         widget.temple.maintowerImage!.isNotEmpty
  //             ? 'https://hrce.tn.gov.in/webservice/documentview.php?file_path=${widget.temple.maintowerImage![0].fileLocation}'
  //             : NetworkImages.templePlaceHolder,
  //         _kGooglePlex!.target,
  //         "temple", () {
  //       _customInfoWindowController.addInfoWindow!(
  //         BuildMarkerInfoWidget(
  //           temple: widget.temple,
  //           customInfoWindowController: _customInfoWindowController,
  //         ),
  //         _kGooglePlex!.target,
  //       );
  //     });

  //     Marker(
  //         markerId: const MarkerId("temple"),
  //         position: _kGooglePlex!.target,
  //         icon: await _getAssetIcon(
  //                 context,
  //                 widget.temple.maintowerImage!.isNotEmpty
  //                     ? 'https://hrce.tn.gov.in/webservice/documentview.php?file_path=${widget.temple.maintowerImage![0].fileLocation}'
  //                     : NetworkImages.templePlaceHolder)
  //             .then((value) => value),
  //         // infoWindow: InfoWindow(
  //         //   title: contact['name'],
  //         //   snippet: 'Street 6 . 2min ago',
  //         // ),
  //         onTap: () {});

  //     setState(() {
  //       _markers.add(marker);
  //     });
  //   });
  // }

  // Stack _builMarkerInfoWidget(BuildContext context, ItmsResponseEntity temple) {
  //   return Stack(
  //     children: [
  //       Container(
  //         padding: const EdgeInsets.all(14.0),
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(12.0),
  //           color: Colors.white,
  //         ),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             SizedBox(
  //               width: double.infinity,
  //               height: 100,
  //               child: ClipRRect(
  //                   borderRadius: BorderRadius.circular(10.0),
  //                   child: CachedNetworkImage(
  //                     imageUrl: temple.maintowerImage!.isNotEmpty
  //                         ? 'https://hrce.tn.gov.in/webservice/documentview.php?file_path=${temple.maintowerImage![0].fileLocation}'
  //                         : NetworkImages.templePlaceHolder,
  //                     imageBuilder: (context, imageProvider) => ClipRRect(
  //                       child: DecoratedBox(
  //                         decoration: BoxDecoration(
  //                             color: Colors.black.withOpacity(0.08),
  //                             image: DecorationImage(
  //                                 image: imageProvider, fit: BoxFit.cover)),
  //                       ),
  //                     ),
  //                   )),
  //             ),
  //             const SizedBox(
  //               height: 15,
  //             ),
  //             Flexible(
  //               child: Text(
  //                 Locales.lang == "en"
  //                     ? temple.templeName ?? ''
  //                     : temple.ttempleName ?? "",
  //                 style: const TextStyle(
  //                     color: Colors.black,
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 12),
  //                 textAlign: TextAlign.center,
  //                 overflow: TextOverflow.ellipsis,
  //                 maxLines: 3,
  //               ),
  //             ),
  //             const SizedBox(
  //               height: 5,
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 MaterialButton(
  //                   onPressed: () {
  //                     Navigator.pushNamed(context, '/TempleDetails',
  //                         arguments: temple);
  //                     _customInfoWindowController.hideInfoWindow!();
  //                   },
  //                   elevation: 0,
  //                   height: 20,
  //                   color: Theme.of(context).colorScheme.primary,
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(10.0),
  //                   ),
  //                   child: const Padding(
  //                     padding: EdgeInsets.all(8.0),
  //                     child: Text(
  //                       "Temple Info",
  //                       style: TextStyle(
  //                           fontWeight: FontWeight.bold, color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //                 MaterialButton(
  //                   onPressed: () async {
  //                     _customInfoWindowController.hideInfoWindow!();
  //                     // openMapsApp(context, temple);
  //                   },
  //                   elevation: 0,
  //                   height: 20,
  //                   color: Theme.of(context).colorScheme.primary,
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(10.0),
  //                   ),
  //                   child: const Padding(
  //                     padding: EdgeInsets.all(8.0),
  //                     child: Text(
  //                       "Direction",
  //                       style: TextStyle(
  //                           fontWeight: FontWeight.bold, color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             )
  //           ],
  //         ),
  //       ),
  //       Positioned(
  //         top: 5.0,
  //         left: 5.0,
  //         child: IconButton(
  //           icon: const Icon(
  //             Icons.close,
  //             color: Colors.white,
  //           ),
  //           onPressed: () {
  //             _customInfoWindowController.hideInfoWindow!();
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Future<BitmapDescriptor> _getAssetIcon(
      BuildContext context, String icon) async {
    final Completer<BitmapDescriptor> bitmapIcon =
        Completer<BitmapDescriptor>();
    final ImageConfiguration config =
        createLocalImageConfiguration(context, size: const Size(5, 5));

    NetworkImage(icon)
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

  // custom marker
}

class BuildMarkerInfoWidget extends StatelessWidget {
  final ItmsResponseEntity temple;
  final CustomInfoWindowController customInfoWindowController;
  const BuildMarkerInfoWidget(
      {Key? key,
      required this.temple,
      required this.customInfoWindowController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
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
                    child: CachedNetworkImage(
                      imageUrl: temple.maintowerImage!.isNotEmpty
                          ? 'https://hrce.tn.gov.in/webservice/documentview.php?file_path=${temple.maintowerImage![0].fileLocation}'
                          : NetworkImages.templePlaceHolder,
                      imageBuilder: (context, imageProvider) => ClipRRect(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.08),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover)),
                        ),
                      ),
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              Flexible(
                child: Text(
                  Locales.lang == "en"
                      ? temple.templeName ?? ''
                      : temple.ttempleName ?? "",
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/TempleDetails',
                          arguments: temple);
                      customInfoWindowController.hideInfoWindow!();
                    },
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
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      customInfoWindowController.hideInfoWindow!();
                      openMapsApp(context, temple);
                    },
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
                            fontWeight: FontWeight.bold, color: Colors.white),
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
              customInfoWindowController.hideInfoWindow!();
            },
          ),
        ),
      ],
    );
  }

  // open external map apps
  openMapsApp(context, ItmsResponseEntity temple) async {
    try {
      final coords = mapLauncher.Coords(double.parse(temple.templeLatitude!),
          double.parse(temple.templeLangitude!));
      String title = Locales.lang == "en"
          ? temple.templeName?.split(',')[0] ?? ''
          : temple.ttempleName?.split(',')[0] ?? "";
      final availableMaps = await mapLauncher.MapLauncher.installedMaps;
      availableMaps.first.showMarker(coords: coords, title: title);
    } catch (e) {
      print(e);
    }
  }
}
