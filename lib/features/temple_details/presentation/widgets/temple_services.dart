import 'package:flutter/material.dart';

import '../../../../config/constants.dart';
import '../../../dashboard/presentation/widgets/service_list.dart';

buildTempleServices(context) {
  return Padding(
    padding: defaultPadding,
    child:
        buildTempleServicesList(listType: "HL", services: templeServicesList),
  );
}
