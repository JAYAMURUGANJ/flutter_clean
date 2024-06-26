// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '/config/common/extensions.dart';

class DataNotAvailable extends StatefulWidget {
  String error;
  String img;
  DataNotAvailable({
    Key? key,
    required this.error,
    required this.img,
  }) : super(key: key);

  @override
  State<DataNotAvailable> createState() => _DataNotAvailableState();
}

class _DataNotAvailableState extends State<DataNotAvailable> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(widget.img, width: 130, height: 120),
          10.ph,
          LocaleText(
            widget.error,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
