import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../../../../config/common/widgets/something_went_wrong.dart';
import '../../../../config/common/widgets/text_widgets.dart';
import '../../domain/entities/temple_timing.dart';
import '../bloc/temple_timing/temple_timing_bloc.dart';
import '/config/common/extensions.dart';
import '/config/constants.dart';

class TempleTiming extends StatelessWidget {
  const TempleTiming({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TempleTimingBloc, TempleTimingState>(
      listener: (context, state) {
        if (state is TempleTimingLodingError) {
          Navigator.pushNamed(context, '/DioException',
              arguments: state.error!);
        }
        if (state is TempleTimingLoadingSomthingWentWrong) {
          Navigator.pushNamed(context, '/SomthingWentWrong',
              arguments: state.responseStatus!);
        }
      },
      builder: (context, state) {
        if (state is TempleTimingLoading) {
          return const CupertinoActivityIndicator();
        }
        if (state is TempleTimingLoadingSomthingWentWrong) {
          String error = state.responseStatus!;
          return somthingWentWrong(context, error);
        }
        if (state is TempleTimingLoaded) {
          final TempleTimingEntity? templeTiming = state.templeTiming![0];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTimingCard(context, "morning",
                  templeTiming!.mrngOpeningtime, templeTiming.mrngClosingTime),
              20.ph,
              _buildTimingCard(context, "evening", templeTiming.evngOpeningTime,
                  templeTiming.evngClosingTime),
              20.ph,
              buildlabelValueTxt(context, "remarks", templeTiming.remarks),
            ],
          );
        }
        return const Center(child: Text(" No data Available"));
      },
    );
  }

  _buildTimingCard(BuildContext context, String caption, String? openTime,
      String? closeTime) {
    return Padding(
      padding: defaultPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LocaleText(
            caption,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary),
          ),
          DataTable(
              border: TableBorder.all(
                  width: 1,
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black),
              headingRowColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.primaryContainer),
              headingRowHeight: 45,
              headingTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
              dataTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              columnSpacing: 2,
              clipBehavior: Clip.antiAlias,
              columns: [
                DataColumn(
                    label: Expanded(
                  child: LocaleText(
                    "opening_time",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                )),
                DataColumn(
                    label: Expanded(
                        child: LocaleText(
                  "closing_time",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ))),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Align(
                      alignment: Alignment.center,
                      child: Text(openTime ?? "-"))),
                  DataCell(Align(
                      alignment: Alignment.center,
                      child: Text(closeTime ?? "-")))
                ]),
              ]),
        ],
      ),
    );
  }
}