import 'package:flutter/material.dart';
import 'package:news_app_clean_architecture/config/common/extensions.dart';
import 'package:news_app_clean_architecture/config/constants.dart';

somthingWentWrong(BuildContext context, String error, {String errorIcon = ""}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        20.ph,
        Container(
          padding: const EdgeInsetsDirectional.only(
              start: 14, end: 14, bottom: 7, top: 7),
          height: MediaQuery.of(context).size.width / 2.2,
          child: Image.asset(
              errorIcon.isNotEmpty ? errorIcon : LocalImages.somthingWentWrong),
        ),
        Text(
          error,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}
