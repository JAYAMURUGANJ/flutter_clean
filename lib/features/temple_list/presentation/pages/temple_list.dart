import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../../../../config/common/widgets/app_header.dart';
import '../../../../config/common/widgets/navigation_drawer.dart';
import '../../../../config/constants.dart';
import '../widgets/temple_list.dart';

TextEditingController searchFieldController = TextEditingController();

ValueNotifier<bool> showFilterWidget = ValueNotifier(true);

class TempleListPage extends StatefulWidget {
  const TempleListPage({Key? key}) : super(key: key);

  @override
  State<TempleListPage> createState() => _TempleListPageState();
}

class _TempleListPageState extends State<TempleListPage> {
  @override
  void initState() {
    super.initState();
    searchFieldController.clear();
    showFilterWidget.value = false;
    godSelected.value = -1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appHeader(
        context: context,
        body: LocaleText("temple_list",
            textAlign: TextAlign.center,
            style: appbarTextStyleLarge(Theme.of(context))),
        trailing: IconButton(
          onPressed: () => buildNavigationDrawer(context),
          icon: const Icon(Icons.menu),
        ),
      ),
      body: alltempleListBlocBuilder(),
    );
  }
}
