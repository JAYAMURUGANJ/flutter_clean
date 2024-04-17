import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../../../../config/common/extensions.dart';
import '../../../../config/common/widgets/card_carousel.dart';
import '../../../../config/constants.dart';

Padding buildWhatsNewList(BuildContext context) {
  return Padding(
    padding: defaultPadding,
    child: SizedBox(
      height: 126,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LocaleText("whats_new",
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(fontWeight: FontWeight.bold)),
          5.ph,
          const WhatsNewIndicatior()
        ],
      ),
    ),
  );
}
