import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/config/common/extensions.dart';
import 'package:news_app_clean_architecture/features/temple_details/domain/entities/facility.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/bloc/facility/facility_bloc.dart';

import '../../../../config/common/pages/error/something_went_wrong_screen.dart';
import '../../../../config/constants.dart';
import '../../../temple_list/domain/entities/itms_response.dart';

class FacilityWidget extends StatefulWidget {
  final ItmsResponseEntity? templeData;
  const FacilityWidget({Key? key, this.templeData}) : super(key: key);

  @override
  State<FacilityWidget> createState() => _FacilityWidgetState();
}

class _FacilityWidgetState extends State<FacilityWidget> {
  @override
  void initState() {
    BlocProvider.of<FacilityBloc>(context).add(
        GetFacilityEvent(templeId: widget.templeData!.templeId.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FacilityBloc, FacilityState>(
      builder: (context, state) {
        if (state is FacilityLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is FacilityLoadingError) {
          return ErrorWidget(state.error.toString());
        }
        if (state is FacilityLoadingSomthingWentWrong) {
          return SomethingWentWrong(error: state.responseStatus.toString());
        }
        if (state is FacilityLoaded) {
          List<FacilityEntity> facilityList =
              state.facility!.cast<FacilityEntity>();
          return ListView.builder(
            itemCount: facilityList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 8,
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        height: 230,
                        width: double.infinity,
                        placeholder: (context, url) =>
                            const CupertinoActivityIndicator(),
                        imageUrl: ApiCredentials().documents +
                            facilityList[index]
                                .facilityImage![0]
                                .fileLocation
                                .toString(),
                        imageBuilder: (context, imageProvider) => ClipRRect(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                //   color: Colors.black.withOpacity(0.08),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover)),
                          ),
                        ),
                      ),
                      Text(facilityList[index].facilityTitle ?? ""),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return 0.pw;
      },
    );
  }
}
