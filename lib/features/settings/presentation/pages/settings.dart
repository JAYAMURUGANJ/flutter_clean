import 'package:feedback/feedback.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:news_app_clean_architecture/config/common/extensions.dart';

import '../widgets/favorite_temples.dart';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: SingleChildScrollView(
          child: Column(children: [
            const LabelText(label: 'language'),
            const LanguageList(isRow: true),
            25.ph,
            const LabelText(label: 'app_theme'),
            const ThemeList(),
            25.ph,
            GestureDetector(
              onTap: () {
                favoriteGodBottomsheet(context);
              },
              child: SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LocaleText(
                        "favorite_god",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      const Icon(Icons.arrow_forward)
                    ],
                  )),
            ),
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

  Future<dynamic> favoriteGodBottomsheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (sheetContext) => Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 24),
                    child: LocaleText(
                      "favorite_god",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const FavoriteTemplesWidget(),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                        onPressed: () {
                          Navigator.pop(sheetContext);
                        },
                        child: const LocaleText("ok")),
                  )
                ],
              )),
            ));
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
