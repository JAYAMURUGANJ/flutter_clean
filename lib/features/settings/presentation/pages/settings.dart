import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../widgets/language_list.dart';
import '../widgets/theme_list.dart';
import '/config/common/widgets/app_header.dart';
import '/config/common/widgets/navigation_drawer.dart';
import '/config/constants.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    dynamic theme = Theme.of(context);
    return Scaffold(
      appBar: appHeader(
          context: context,
          body: LocaleText(
            "settings",
            textAlign: TextAlign.center,
            style: appbarTextStyleLarge(theme),
          ),
          trailing: IconButton(
              onPressed: () => buildNavigationDrawer(context),
              icon: const Icon(Icons.menu))),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: SingleChildScrollView(
          child: Column(children: [
            LabelText(label: 'language'),
            LanguageList(isRow: true),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BetterFeedback.of(context).show((p0) => debugPrint(p0.text));
        },
        child: const Icon(Icons.feedback),
      ),
    );
  }
}

class LabelText extends StatelessWidget {
  final String label;
  const LabelText({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SizedBox(
        width: double.infinity,
        child: LocaleText(
          label,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
