import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../../../../config/common/widgets/cloud_arc.dart';
import '../../../temple_list/domain/entities/itms_response.dart';
import '/config/common/widgets/app_header.dart';
import '/config/common/widgets/navigation_drawer.dart';
import '/config/constants.dart';

class TempleLiveStreams extends StatefulWidget {
  final ItmsResponseEntity? templeData;
  const TempleLiveStreams({
    Key? key,
    this.templeData,
  }) : super(key: key);

  @override
  State<TempleLiveStreams> createState() => _TempleLiveStreamsState();
}

class _TempleLiveStreamsState extends State<TempleLiveStreams> {
  @override
  Widget build(BuildContext context) {
    dynamic theme = Theme.of(context);
    return Scaffold(
      appBar: (widget.templeData?.templeId != null)
          ? null
          : appHeader(
              context: context,
              body: LocaleText("live_events",
                  textAlign: TextAlign.center,
                  style: appbarTextStyleLarge(theme)),
              trailing: IconButton(
                onPressed: () => buildNavigationDrawer(context),
                icon: const Icon(Icons.menu),
              ),
            ),
      body: Stack(
        // alignment: AlignmentDirectional.topStart,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 180),
              painter: CloudArcPainter(
                  themeColor: Theme.of(context).colorScheme.primary),
            ),
          ),
          Center(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // number of items in each row
                mainAxisSpacing: 10.0, // spacing between rows
                crossAxisSpacing: 8.0, // spacing between columns
              ),
              padding: const EdgeInsets.all(8.0),
              itemCount: liveStreamType.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      width: 160,
                      height: 130,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          liveStreamType[index].imageLink,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Text(
                        Locales.lang == "en"
                            ? liveStreamType[index].steamType
                            : liveStreamType[index].tsteamType,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
