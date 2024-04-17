import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/config/constants.dart';

import '../../../../config/common/widgets/something_went_wrong.dart';
import '../../../../config/common/widgets/text_widgets.dart';
import '../../domain/entities/temple_info.dart';
import '../bloc/temple_info/temple_info_bloc.dart';

class TempleInfoWidget extends StatelessWidget {
  const TempleInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TempleInfoBloc, TempleInfoState>(
      listener: (context, state) {
        if (state is TempleInfoLodingError) {
          Navigator.pushNamed(context, '/DioException',
              arguments: state.error!);
        }
        if (state is TempleInfoLoadingSomthingWentWrong) {
          Navigator.pushNamed(context, '/SomthingWentWrong',
              arguments: state.responseStatus!);
        }
      },
      builder: (context, state) {
        if (state is TempleInfoLoading) {
          return const CupertinoActivityIndicator();
        }
        if (state is TempleInfoLoadingSomthingWentWrong) {
          String error = state.responseStatus!;
          return somthingWentWrong(context, error);
        }
        if (state is TempleInfoLoaded) {
          final TempleInfoEntity? templeInfo = state.templeInfo![0];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildlabelValueTxt(
                  context, "moolavar", templeInfo!.moolavarSwamiName),
              buildlabelValueTxt(
                  context, "moolavar_ambal", templeInfo.moolavarAmbalName),
              buildlabelValueTxt(
                  context, "thala_virutcham", templeInfo.sthalaVirutcham),
              buildlabelValueTxt(
                  context, "theertham", templeInfo.templeTheertham),
              buildlabelValueTxt(context, "aagamam", templeInfo.aagamamDesc),
              buildlabelValueTxt(
                  context, "historical_name", templeInfo.historicalName),
              buildlabelValueTxt(context, "saints_poets", templeInfo.poetName),
              _templeDescription(templeInfo, context),
            ],
          );
        }
        return const Center(child: Text(" No data Available"));
      },
    );
  }

  Padding _templeDescription(
      TempleInfoEntity templeInfo, BuildContext context) {
    return Padding(
      padding: defaultPadding,
      child: Text(templeInfo.description ?? "-",
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
