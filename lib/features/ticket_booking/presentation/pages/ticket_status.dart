// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../config/common/widgets/app_header.dart';
import '../widgets/ticket.dart';
import '/config/common/extensions.dart';
import '/config/common/widgets/app_logo.dart';
import '/config/constants.dart';

class PaymentStatus extends StatefulWidget {
  const PaymentStatus({Key? key}) : super(key: key);

  @override
  State<PaymentStatus> createState() => _PaymentStatusState();
}

class _PaymentStatusState extends State<PaymentStatus> {
  final GlobalKey _globalKey = GlobalKey();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimaryContainer,
      appBar: appHeader(
          context: context,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white)),
          body: LocaleText("txn_details",
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium!
                  .copyWith(fontSize: 16, color: Colors.white)),
          trailing: IconButton(
              onPressed: _capturePng,
              icon: const Icon(Icons.share_sharp, color: Colors.white))),
      body: ticketDetails(context, theme),
    );
  }

  Widget ticketDetails(BuildContext context, ThemeData theme) {
    return SingleChildScrollView(
      child: RepaintBoundary(
        key: _globalKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: TicketWidget(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).width * 1.8,
                  isCornerRounded: true,
                  padding: const EdgeInsets.all(20),
                  child: TicketData(
                    theme: theme,
                  ),
                ),
              ),
            ),
            50.ph,
          ],
        ),
      ),
    );
  }

  void _capturePng() async {
    try {
      // Scroll to the bottom to ensure the entire widget is rendered
      Scrollable.ensureVisible(_globalKey.currentContext!,
          duration: const Duration(seconds: 1), alignment: 5.0);

      // Delay to allow for scrolling
      await Future.delayed(const Duration(seconds: 1));

      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/image.png').create();
      file.writeAsBytesSync(pngBytes);
      Share.shareXFiles([XFile('${tempDir.path}/image.png')],
          text: 'Thirukoil Ticket');
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

class TicketData extends StatefulWidget {
  ThemeData theme;
  TicketData({
    Key? key,
    required this.theme,
  }) : super(key: key);

  @override
  State<TicketData> createState() => _TicketDataState();
}

class _TicketDataState extends State<TicketData> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            LocalImages().wm,
            width: 250,
            fit: BoxFit.contain,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppIcon(height: 40),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: LocaleText(
                      "thirukoil",
                      style: widget.theme.textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: widget.theme.colorScheme.primary),
                    ),
                  ),
                ),
                Image.asset(
                  LocalImages().tnLogo,
                  height: 40,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: SizedBox(
                    width: 220,
                    child: Text(
                      'அருள்மிகு நரசிம்ம சுவாமி திருக்கோயில், நாமக்கல் பேருந்து நிலையம் அருகில், நாமக்கல் - 637001',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.clip,
                      maxLines: 7,
                      style: widget.theme.textTheme.bodySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Scaffold.of(context).showBottomSheet(
                      (BuildContext context) {
                        return Container(
                          color: Colors.white,
                          height: MediaQuery.sizeOf(context).width,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                        onPressed: () => Navigator.pop(context),
                                        icon: const Icon(Icons.close)),
                                  ),
                                  5.ph,
                                  LocaleText(
                                    "qr_verify",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  10.ph,
                                  QrImageView(
                                    data: 'S0000624052100003076',
                                    version: QrVersions.auto,
                                    size: 180,
                                    eyeStyle: const QrEyeStyle(
                                        eyeShape: QrEyeShape.square,
                                        color: Colors.black),
                                    dataModuleStyle: const QrDataModuleStyle(
                                        dataModuleShape:
                                            QrDataModuleShape.square,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: QrImageView(
                    data: 'S0000624052100003076',
                    version: QrVersions.auto,
                    size: 80,
                    eyeStyle: QrEyeStyle(
                        eyeShape: QrEyeShape.square,
                        color: widget.theme.colorScheme.primary),
                    dataModuleStyle: QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.square,
                        color: widget.theme.colorScheme.primary),
                    // gapless: true,
                    // embeddedImage: AssetImage(LocalImages().appLogo),
                    // embeddedImageStyle: const QrEmbeddedImageStyle(
                    //   size: Size(75, 75),
                    // ),
                  ),
                ),
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: SizedBox(
                  child: Text(
                    'அர்ச்சனை டிக்கெட் [₹ 50/-]',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    maxLines: 3,
                    style: widget.theme.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: widget.theme.colorScheme.primary),
                  ),
                ),
              ),
            ),
            Container(
              height: 90,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                // color: Colors.yellow[100],
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "10:00",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          10.pw,
                          const Text(
                            "AM",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Text(
                        "to",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          const Text(
                            "12:00",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          10.pw,
                          const Text(
                            "PM",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const VerticalDivider(),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('MMM').format(DateTime.now()),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat('dd').format(DateTime.now()),
                          style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              color: widget.theme.colorScheme.primary),
                        ),
                        Text(
                          DateFormat('yy').format(DateTime.now()),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ticketDetailsWidget(
                    'ரசீது எண்:', 'S0000624052100003076', "", ""),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "தொகை:\n(5 X ₹ 50)",
                        style: widget.theme.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: widget.theme.colorScheme.primary,
                        ),
                      ),
                      Text(
                        "₹ 250.00/-",
                        style: widget.theme.textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: widget.theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                ticketDetailsWidget(
                    'கட்டண வகை', 'UPI: 9566632370@hdfcbank', "", ""),
                ticketDetailsWidget(
                    'வங்கி குறிப்பு எண்', '413018291522', "", ""),
                ticketDetailsWidget(
                    'அடையாள எண்', 'AADHAR - 62xx xxxx xxxx xx56', "", ""),
                ticketDetailsWidget(
                    'பக்தர் பெயர்', 'ஜெயமுருகன் ஜெயக்குமார்', "", ""),
              ],
            ),
            const SizedBox(height: 10)
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "கட்டணமில்லா எண்:",
                style: widget.theme.textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "1800-425-1757",
                style: widget.theme.textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget ticketDetailsWidget(String firstTitle, String firstDesc,
    String secondTitle, String secondDesc) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              firstTitle,
              style: TextStyle(
                  color: Colors.grey.shade600, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                firstDesc,
                softWrap: true,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              secondTitle,
              style: TextStyle(
                  color: Colors.grey.shade600, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                secondDesc,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      )
    ],
  );
}

Padding label1(String title, String desc, EdgeInsetsGeometry padding) {
  return Padding(
    padding: padding,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: TextStyle(
                color: Colors.grey.shade600, fontWeight: FontWeight.bold),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              desc,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    ),
  );
}

Padding label2(
    String firstTitle, String firstDesc, EdgeInsetsGeometry padding) {
  return Padding(
    padding: padding,
    child: Row(
      children: <Widget>[
        Text(
          firstTitle,
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.grey.shade600, fontWeight: FontWeight.bold),
        ),
        20.pw,
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            firstDesc,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        )
      ],
    ),
  );
}
