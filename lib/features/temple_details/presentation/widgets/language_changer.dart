import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../config/common/class/local_language_controller.dart';
import '../bloc/speciality/speciality_bloc.dart';
import '../bloc/temple_info/temple_info_bloc.dart';
import '../bloc/temple_pooja/temple_pooja_bloc.dart';
import '../bloc/temple_timing/temple_timing_bloc.dart';

void getTempledata(context, templeId) {
  BlocProvider.of<TempleInfoBloc>(context)
      .add(GetTempleInfo(templeId: templeId.toString()));
  BlocProvider.of<TempleTimingBloc>(context)
      .add(GetTempleTiming(templeId: templeId.toString()));
  BlocProvider.of<TemplePoojaBloc>(context)
      .add(GetTemplePooja(templeId: templeId.toString()));
  BlocProvider.of<SpecialityBloc>(context)
      .add(GetSpeciality(templeId: templeId.toString()));
}

languageChanger(BuildContext context, String templeId) {
  getTempledata(context, templeId);
  final LocalizationController localizationController =
      Get.find<LocalizationController>();
  return localizationController.currentLanguage == 'en'
      ? IconButton(
          onPressed: () {
            localizationController.changeLocale("ta");
          },
          isSelected: true,
          icon: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                "அ",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontStyle: FontStyle.normal,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ),
        )
      : IconButton(
          onPressed: () {
            localizationController.changeLocale("en");
          },
          isSelected: true,
          icon: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                "A",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontStyle: FontStyle.normal,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ),
        );
}
