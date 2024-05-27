// ignore_for_file: library_private_types_in_public_api, avoid_function_literals_in_foreach_calls, library_prefixes

import 'dart:async';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart' as mapLauncher;

import '../../../../config/common/widgets/app_header.dart';
import '../../../../config/common/widgets/navigation_drawer.dart';
import '../../../temple_list/presentation/widgets/temple_tile.dart';
import '/config/constants.dart';
import '../../../temple_list/presentation/bloc/itms/itms_bloc.dart';
import '../bloc/show_nearby_temples/show_nearby_temples_bloc.dart';
import '/features/temple_list/domain/entities/itms_response.dart';

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
  // final ItmsResponseEntity? temple;
  final Map<String, dynamic>? data;
  const NearByTemplesWidget({
    Key? key,
    // this.temple,
    this.data,
  }) : super(key: key);

  @override
  _NearByTemplesWidgetState createState() => _NearByTemplesWidgetState();
}

class _NearByTemplesWidgetState extends State<NearByTemplesWidget>
    with TickerProviderStateMixin {
  CameraPosition? _kGooglePlex;
  late GoogleMapController _controller;
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  List<ItmsResponseEntity> listOfTemples = [];
  int selectedIndex = 0;
  final ValueNotifier<int> _selectedDistanceIndex = ValueNotifier(-1);
  final DraggableScrollableController _draggableScrollableController =
      DraggableScrollableController();

  @override
  void initState() {
    listOfTemples = BlocProvider.of<ITMSBloc>(context).state.templeList
        as List<ItmsResponseEntity>;
    _kGooglePlex = const CameraPosition(
      target: LatLng(37.4220936, -122.083922),
      zoom: 13.4746,
    );

    if (widget.data?['temple'] != null) {
      double templeLat = double.parse(widget.data?['temple'].templeLatitude!);
      double templeLang = double.parse(widget.data?['temple'].templeLangitude!);

      _kGooglePlex = CameraPosition(
        target: LatLng(templeLat, templeLang),
        zoom: 13.4746,
      );
      BlocProvider.of<ShowNearbyTemplesBloc>(context).add(ViewSingleTempleEvent(
          widget.data?['temple'], _customInfoWindowController));
    } else if (widget.data?['current_location'] != null) {
      _selectedDistanceIndex.value =
          distanceList.indexOf(widget.data?['distance'] ?? 5.0);
      // zoom level
      double zoomLevel = widget.data?['distance'] ?? 5.0;
      double reduceValue = (zoomLevel / 5) - 1;
      zoomLevel = 13.0 - (reduceValue > 3 ? (3 + .3) : reduceValue);

      _kGooglePlex = CameraPosition(
        target: LatLng(widget.data?['current_location'].latitude!,
            widget.data?['current_location'].longitude!),
        zoom: zoomLevel,
      );

      BlocProvider.of<ShowNearbyTemplesBloc>(context).add(
          ViewCurrentLocationEvent(
              fromCurrentLocation: true,
              currentLocationLatLng: LatLng(
                  widget.data?['current_location'].latitude!,
                  widget.data?['current_location'].longitude!),
              listOfTemples: listOfTemples,
              customInfoWindowController: _customInfoWindowController,
              distance: widget.data?['distance']));
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
    dynamic theme = Theme.of(context);

    return Scaffold(
        appBar: appHeader(
          context: context,
          body: LocaleText("location",
              textAlign: TextAlign.center, style: appbarTextStyleLarge(theme)),
          trailing: (widget.data?['temple'] != null)
              ? const CloseButton()
              : IconButton(
                  onPressed: () => buildNavigationDrawer(context),
                  icon: const Icon(Icons.menu),
                ),
        ),
        body: BlocConsumer<ShowNearbyTemplesBloc, ShowNearbyTemplesState>(
          listener: (context, markerState) {},
          builder: (context, markerState) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 138),
                  child: Listener(
                    onPointerDown: (PointerDownEvent event) =>
                        shrinkBottomSheet(),
                    onPointerMove: (PointerMoveEvent event) =>
                        shrinkBottomSheet(),
                    onPointerUp: (PointerUpEvent event) => shrinkBottomSheet(),
                    child: GoogleMap(
                      initialCameraPosition: _kGooglePlex!,
                      //  myLocationButtonEnabled: true,
                      myLocationEnabled:
                          widget.data?['current_location'] != null
                              ? true
                              : false,
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
                  ),
                ),
                CustomInfoWindow(
                  controller: _customInfoWindowController,
                  height: 240,
                  width: 280,
                  offset: 60.0,
                ),

                //for map theme changing
                Positioned(
                  top: 25,
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
                ),
                // bottom sheet
                DraggableScrollableSheet(
                    initialChildSize: .2,
                    minChildSize: .2,
                    maxChildSize: .6,
                    controller: _draggableScrollableController,
                    shouldCloseOnMinExtent: false,
                    builder: ((context, ScrollController scrollController) {
                      return SingleChildScrollView(
                        controller: scrollController,
                        child: Container(
                            height: MediaQuery.of(context).size.height * .48,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(18),
                                  topRight: Radius.circular(18),
                                ),
                                color: Theme.of(context).colorScheme.surface),
                            child: _buildNearbyTemplesWidget()),
                      );
                    })),
              ],
            );
            // }
          },
        ));
  }

  Future<void> shrinkBottomSheet() {
    return _draggableScrollableController.animateTo(
      0.2,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  Column _buildNearbyTemplesWidget() {
    return Column(
      children: [
        IgnorePointer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 15),
                height: 5,
                width: 75,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade400),
              ),
            ],
          ),
        ),
        LocaleText(
          "Select_distance",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(
            height: 60,
            width: double.infinity,
            child: ValueListenableBuilder(
                valueListenable: _selectedDistanceIndex,
                builder: (context, value, child) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemExtent: 90,
                    itemCount: distanceList.length,
                    itemBuilder: (context, index) => ChoiceChip(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.green.shade900, width: 2.0),
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                      selectedColor: _selectedDistanceIndex.value == index
                          ? Colors.green
                          : Colors.transparent,
                      showCheckmark: false,
                      label: Text(
                        "${distanceList[index].round().toString()} KM",
                        style: TextStyle(
                            fontSize: 15,
                            color: _selectedDistanceIndex.value == index
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      selected: _selectedDistanceIndex.value == index,
                      onSelected: (value) {
                        expandBottomSheet();
                        _customInfoWindowController.hideInfoWindow!();
                        _selectedDistanceIndex.value = index;
                        // zoom level
                        double zoomLevel = distanceList[index];
                        double reduceValue = (zoomLevel / 5) - 1;
                        zoomLevel =
                            13.0 - (reduceValue > 3 ? (3 + .3) : reduceValue);
                        // animate zoom
                        _controller.animateCamera(
                            CameraUpdate.newCameraPosition(CameraPosition(
                                target: _kGooglePlex!.target,
                                zoom: zoomLevel)));
                        if (widget.data?['current_location'] != null) {
                          BlocProvider.of<ShowNearbyTemplesBloc>(context).add(
                              ViewCurrentLocationEvent(
                                  fromCurrentLocation: true,
                                  currentLocationLatLng: LatLng(
                                      widget
                                          .data?['current_location'].latitude!,
                                      widget.data?['current_location']
                                          .longitude!),
                                  listOfTemples: listOfTemples,
                                  customInfoWindowController:
                                      _customInfoWindowController,
                                  distance: distanceList[index]));
                        } else {
                          BlocProvider.of<ShowNearbyTemplesBloc>(context).add(
                              ViewNearByTemplesEvent(
                                  fromCurrentLocation: false,
                                  currentTemple: widget.data?['temple'],
                                  listOfTemples: listOfTemples,
                                  customInfoWindowController:
                                      _customInfoWindowController,
                                  distance: distanceList[index]));
                        }
                      },
                    ),
                  );
                })),
        const SizedBox(
          height: 10,
        ),
        Flexible(
            child: BlocBuilder<ShowNearbyTemplesBloc, ShowNearbyTemplesState>(
          builder: (context, nearbyState) {
            if (nearbyState is ViewMarkersState &&
                nearbyState.filteredTemples != null &&
                nearbyState.markers.length > 1) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: nearbyState.markers.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      child: TempleListTile(
                        temple: nearbyState.filteredTemples![index],
                        onTemplePressed: (value) {
                          ///
                          _controller.moveCamera(CameraUpdate.newLatLng(LatLng(
                              double.parse(nearbyState
                                  .filteredTemples![index].templeLatitude!),
                              double.parse(nearbyState
                                  .filteredTemples![index].templeLangitude!))));
                          _controller.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                  target: LatLng(
                                      double.parse(nearbyState
                                          .filteredTemples![index]
                                          .templeLatitude!),
                                      double.parse(nearbyState
                                          .filteredTemples![index]
                                          .templeLangitude!)),
                                  zoom: 13)));
                        },
                      ),
                    );
                  });
            }
            return const SizedBox.shrink();
          },
        ))
      ],
    );
  }

  Future<void> expandBottomSheet() {
    return _draggableScrollableController.animateTo(
      0.6,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOutBack,
    );
  }

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
      debugPrint(e.toString());
    }
  }
}
