import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../widgets/language_list.dart';
import '../widgets/theme_list.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(children: [
            LabelText(label: 'language'),
            LanguageList(),
            SizedBox(
              height: 25,
            ),
            LabelText(label: 'app_theme'),
            ThemeList(),
            SizedBox(
              height: 25,
            ),
            LabelText(label: 'favorite_temples'),
            // FavoriteTemples()
          ]),
        ),
      ),
    );
  }
}

class LabelText extends StatelessWidget {
  final String label;
  const LabelText({key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SizedBox(
        width: double.infinity,
        child: LocaleText(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
