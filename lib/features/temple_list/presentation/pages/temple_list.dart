import 'package:flutter/material.dart';

import '../../../../config/common/widgets/app_header.dart';
import '../../../../config/common/widgets/navigation_drawer.dart';
import '../widgets/search_bar.dart';
import '../widgets/temple_list.dart';

TextEditingController searchFieldController = TextEditingController();

class TempleListPage extends StatefulWidget {
  const TempleListPage({Key? key}) : super(key: key);

  @override
  State<TempleListPage> createState() => _TempleListPageState();
}

class _TempleListPageState extends State<TempleListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appHeader(
          context: context,
          body: searchWidget(context, searchFieldController),
          trailing: IconButton(
              onPressed: () => buildNavigationDrawer(context),
              icon: const Icon(Icons.menu))),
      body: alltempleListBlocBuilder(),
    );
  }
}
