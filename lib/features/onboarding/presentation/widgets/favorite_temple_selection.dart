import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:news_app_clean_architecture/config/common/extensions.dart';

import '../../../settings/presentation/widgets/favorite_god.dart';

class FavoriteTemplesSelection extends StatefulWidget {
  const FavoriteTemplesSelection({Key? key}) : super(key: key);

  @override
  State<FavoriteTemplesSelection> createState() =>
      _FavoriteTemplesSelectionState();
}

class _FavoriteTemplesSelectionState extends State<FavoriteTemplesSelection> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          width: screenWidth,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Image.asset(
                "assets/images/icons/god_selection.png",
                scale: 0.8,
              ),
              Positioned(
                right: 10,
                bottom: 10,
                child: SizedBox(
                  width: screenWidth * .6,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.topRight,
                    child: LocaleText(
                      "choose_favorite_god",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontWeight: FontWeight.w900),
                      textAlign: TextAlign.right,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        16.ph,
        const Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(child: FavoriteTemplesWidget()),
          ),
        ),
      ],
    );
  }
}
