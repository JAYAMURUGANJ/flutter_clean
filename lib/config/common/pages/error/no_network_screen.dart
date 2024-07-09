import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:news_app_clean_architecture/config/common/extensions.dart';

import '../../../constants.dart';
import '../../widgets/app_header.dart';

class NoNetWork extends StatefulWidget {
  const NoNetWork({
    Key? key,
  }) : super(key: key);

  @override
  State<NoNetWork> createState() => _NoNetWorkState();
}

class _NoNetWorkState extends State<NoNetWork> {
  @override
  Widget build(BuildContext context) {
    dynamic theme = Theme.of(context);
    return Scaffold(
      appBar: appHeader(
        context: context,
        body: Align(
          alignment: Alignment.center,
          child: LocaleText("thirukoil",
              textAlign: TextAlign.center, style: appbarTextStyleLarge(theme)),
        ),
        trailing: const Icon(
          Icons.error_outline_rounded,
          color: Colors.grey,
          size: 50,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 150,
              child: Image.asset(LocalImages().networkError),
            ),
            const LocaleText(
              "no_network",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
            25.ph,
          ],
        ),
      ),
    );
  }
}
