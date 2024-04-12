import 'package:flutter/material.dart';

import '../../../../config/common/widgets/app_header.dart';
import '../widgets/search_bar.dart';
import '../widgets/temple_list.dart';

TextEditingController searchFieldController = TextEditingController();

class TempleList extends StatefulWidget {
  const TempleList({Key? key}) : super(key: key);

  @override
  State<TempleList> createState() => _TempleListState();
}

class _TempleListState extends State<TempleList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appHeader(
          context: context,
          body: searchWidget(context, searchFieldController),
          trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.menu))),
      body: alltempleListBlocBuilder(),
    );
  }
}
