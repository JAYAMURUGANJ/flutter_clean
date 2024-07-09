import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:news_app_clean_architecture/config/common/widgets/loader.dart';

import '../../../../config/common/widgets/app_header.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
        backgroundColor: theme.colorScheme.onPrimaryContainer,
        appBar: appHeader(
          context: context,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white)),
          body: LocaleText("txn_details",
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium!
                  .copyWith(fontSize: 16, color: Colors.white)),
          trailing: const SizedBox(),
        ),
        body: Loader(controller: _controller));
  }
}
