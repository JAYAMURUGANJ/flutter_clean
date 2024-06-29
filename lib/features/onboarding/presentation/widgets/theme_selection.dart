import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:news_app_clean_architecture/config/common/extensions.dart';

import '../../../settings/presentation/widgets/theme_list.dart';

class ThemeSelectionWidget extends StatefulWidget {
  const ThemeSelectionWidget({Key? key}) : super(key: key);

  @override
  State<ThemeSelectionWidget> createState() => _ThemeSelectionWidgetState();
}

class _ThemeSelectionWidgetState extends State<ThemeSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            "assets/images/icons/theme_selection.png",
            scale: 1.2,
          ),
          10.ph,
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.topCenter,
            child: LocaleText(
              "choose_theme",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontWeight: FontWeight.w900),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          20.ph,
          const ThemeList(),
        ],
      ),
    );
  }
}
