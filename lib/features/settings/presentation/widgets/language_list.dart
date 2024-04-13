import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class LanguageList extends StatefulWidget {
  const LanguageList({Key? key}) : super(key: key);

  @override
  State<LanguageList> createState() => _LanguageListState();
}

class _LanguageListState extends State<LanguageList> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(2, (index) {
        selectedIndex = Locales.lang == "en" ? 0 : 1;
        return ChoiceChip(
          showCheckmark: false,
          labelPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          label: Text(index == 0 ? 'English' : 'தமிழ்'),
          labelStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: selectedIndex == index ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2),
          selected: selectedIndex == index,
          selectedColor: Theme.of(context).colorScheme.primary,
          backgroundColor: Colors.black.withOpacity(0.1),
          onSelected: (value) {
            index == 0
                ? context.changeLocale('en')
                : context.changeLocale('ta');
            context.currentLocale!.languageCode == 'en'
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
