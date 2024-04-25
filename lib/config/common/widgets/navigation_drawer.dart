import 'package:flutter/material.dart';

import '../../../features/dashboard/presentation/widgets/service_list.dart';
import '../../constants.dart';

buildNavigationDrawer(context) {
  dynamic theme = Theme.of(context);
  List<Widget> children = List.generate(drawerList.length,
      (e) => otherServiceCard(e, context, 80, 80, 14, drawerList));
  return showModalBottomSheet(
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 300.0,
                automaticallyImplyLeading: false,
                collapsedHeight: 300.0,
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      applyTextScaling: true,
                      color: Colors.black,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    LocalImages().drawerBg,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ];
          },
          body: Card(
            color: const Color.fromARGB(255, 248, 253, 219),
            child: Center(
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height / 2,
                child: Padding(
                  padding: defaultPadding,
                  child: Wrap(
                    spacing: 50.0,
                    runSpacing: 50.0,
                    children: children,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
