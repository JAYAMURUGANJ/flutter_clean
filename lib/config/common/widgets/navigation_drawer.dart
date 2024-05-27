import 'package:flutter/material.dart';

import '../../../features/dashboard/presentation/widgets/service_list.dart';
import '../../constants.dart';

buildNavigationDrawer(context) {
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
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height / 2,
              child: Padding(
                padding: defaultPadding,
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  padding: const EdgeInsets.all(4.0),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  children: children,
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
