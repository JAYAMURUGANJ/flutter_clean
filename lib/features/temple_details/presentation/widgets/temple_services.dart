import 'package:flutter/material.dart';
import 'package:news_app_clean_architecture/features/temple_list/domain/entities/temple_list_response.dart';

import '../../../../config/constants.dart';
import '../../../dashboard/presentation/widgets/service_list.dart';

buildTempleServices(context, TempleListResponseEntity? templeData) {
  return Padding(
    padding: defaultPadding,
    child: buildTempleServicesList(
        listType: "HL", services: templeServicesList, templeData: templeData),
  );
}
