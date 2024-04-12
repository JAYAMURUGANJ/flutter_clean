import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../../../../config/common/extensions.dart';
import '../../../../config/common/widgets/text_carousel.dart';

Padding buildWhatsNewList(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    child: SizedBox(
      height: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LocaleText(
            "whats_new",
            textAlign: TextAlign.left,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          5.ph,
          const TextCarousel(
            texts: [
              'Text 1',
              'Text 2',
              'Text 3',
              'Text 4',
              'Text 5',
            ],
          ),
        ],
      ),
    ),
  );
}
