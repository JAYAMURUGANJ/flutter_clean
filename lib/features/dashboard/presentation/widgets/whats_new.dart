import 'package:flutter/material.dart';

import '../../../../config/common/extensions.dart';
import 'whats_new_indicatior.dart';
import '../../../../config/common/widgets/text_widgets.dart';
import '../../../../config/constants.dart';

Padding buildWhatsNewList(BuildContext context) {
  return Padding(
    padding: defaultPadding,
    child: SizedBox(
      height: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildHeading(context, "whats_new"),
          5.ph,
          const WhatsNewIndicatior()
        ],
      ),
    ),
  );
}
