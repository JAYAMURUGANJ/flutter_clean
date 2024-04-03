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
        return ChoiceChip(
          showCheckmark: false,
          labelPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          label: LocaleText(index == 0 ? 'english' : 'tamil'),
          labelStyle: TextStyle(
              color: selectedIndex == index ? Colors.white : Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.2),
          selected: selectedIndex == index,
          selectedColor: Theme.of(context).primaryColor,
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
