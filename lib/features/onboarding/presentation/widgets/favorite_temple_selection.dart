import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:news_app_clean_architecture/config/common/extensions.dart';

import '../../../settings/presentation/widgets/favorite_temples.dart';

class FavoriteTemplesSelection extends StatefulWidget {
  const FavoriteTemplesSelection({Key? key}) : super(key: key);

  @override
  State<FavoriteTemplesSelection> createState() =>
      _FavoriteTemplesSelectionState();
}

class _FavoriteTemplesSelectionState extends State<FavoriteTemplesSelection> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          width: screenWidth,
          child: Positioned(
            left: 0,
            width: screenWidth,
            height: 300,
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
                            .displayMedium!
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
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
              height: screenWidth,
              child:
                  const SingleChildScrollView(child: FavoriteTemplesWidget())),
        )
      ],
    );
  }
}
