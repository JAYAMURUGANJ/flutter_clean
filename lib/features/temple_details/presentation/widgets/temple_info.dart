import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:news_app_clean_architecture/config/common/extensions.dart';

import '../../domain/entities/temple_info.dart';
import '../bloc/temple_info/temple_info_bloc.dart';
import '/config/common/widgets/something_went_wrong.dart';
import '/config/common/widgets/text_widgets.dart';
import '/config/constants.dart';

class TempleInfoWidget extends StatelessWidget {
  const TempleInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TempleInfoBloc, TempleInfoState>(
      builder: (context, state) {
        if (state is TempleInfoLoading) {
          return SizedBox(
              height: MediaQuery.of(context).size.height * .25,
              child: const CupertinoActivityIndicator());
        }
        if (state is TempleInfoLoadingSomthingWentWrong) {
          String error = state.responseStatus!;
          return somthingWentWrong(context, error);
        }
        if (state is TempleInfoLoaded) {
          final TempleInfoEntity? templeInfo = state.templeInfo![0];
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildTabularlabelValueTxt(context, [
                  TitleValue("moolavar", templeInfo!.moolavarSwamiName),
                  TitleValue("moolavar_ambal", templeInfo.moolavarAmbalName),
                  TitleValue("thala_virutcham", templeInfo.sthalaVirutcham),
                  TitleValue("theertham", templeInfo.templeTheertham),
                  TitleValue("aagamam", templeInfo.aagamamDesc),
                  TitleValue("historical_name", templeInfo.historicalName),
                  TitleValue("saints_poets", templeInfo.poetName),
                ]),
                _templeDescription(templeInfo, context),
              ],
            ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          5.ph,
          LocaleText(
            "description",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary),
            textAlign: TextAlign.left,
          ),
          3.ph,
          Text(templeInfo.description ?? "-",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}

// title value model

class TitleValue {
  final String title;
  final String? value;
  TitleValue(this.title, this.value);
}
