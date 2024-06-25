import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:get/get.dart';

import '../../../../config/common/class/local_controller.dart';

class LanguageList extends StatefulWidget {
  final bool isRow;
  const LanguageList({Key? key, required this.isRow}) : super(key: key);

  @override
  State<LanguageList> createState() => _LanguageListState();
}

class _LanguageListState extends State<LanguageList> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final LocalizationController localizationController =
        Get.find<LocalizationController>();

    // padding: const EdgeInsets.symmetric(horizontal: 36),
    return Flex(
      direction: widget.isRow ? Axis.horizontal : Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(2, (index) {
        selectedIndex = Locales.lang == "en" ? 0 : 1;
        return ChoiceChip(
          showCheckmark: false,
          labelPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          label: SizedBox(
              width: 70,
              child: Text(
                index == 0 ? 'English' : 'தமிழ்',
                textAlign: TextAlign.center,
              )),
          labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: selectedIndex == index ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.3),
          selected: selectedIndex == index,
          selectedColor: Theme.of(context).colorScheme.primary,
          backgroundColor: Colors.black.withOpacity(0.1),
          onSelected: (value) {
            index == 0
                ? localizationController.changeLocale('en')
                : localizationController.changeLocale('ta');
            localizationController.currentLanguage == 'en'
                ? selectedIndex = 0
                : selectedIndex = 1;
          },
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          side: const BorderSide(style: BorderStyle.none),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        );
      }),
    );
  }
}
