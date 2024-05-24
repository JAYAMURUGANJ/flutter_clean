// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: TicketWidget(
            width: 350,
            height: 600,
            isCornerRounded: true,
            padding: const EdgeInsets.all(20),
            child: TicketData(
              theme: theme,
            ),
          ),
        ),
      ),
    );
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
    final today = DateTime.now().today;
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        Image.asset(
          LocalImages().wm,
          height: 360,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppIcon(height: 50),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: LocaleText(
                      "thirukoil",
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                    ),
                  ),
                ),
                Image.asset(
                  LocalImages().tnLogo,
                  height: 50,
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Center(
                child: Text(
                  'அருள்மிகு தண்டாயுதபாணி சுவாமி திருக்கோயில், பழனி - 624601',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Center(
                child: Text(
                  'அர்ச்சனை டிக்கெட்',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: widget.theme.colorScheme.primary,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, right: 52.0),
                    child: ticketDetailsWidget(
                        'ரசீது எண்', 'S0000624052100003076', "", ""),
                  ),
                  label2('டிக்கெட் எண்ணிக்கை', '-5',
                      const EdgeInsets.only(left: 12.0)),
                  ticketDetailsWidget('பக்தர்', 'ஜெயமுருகன்', 'தேதி',
                      "${today.day}-${today.month}-${today.year}"),
                  ticketDetailsWidget('பார்வை நேரம்', '10.00 am - 12.00 pm',
                      'கட்டணம்', " ₹ 250/-"),
                  ticketDetailsWidget(
                      'கட்டணம் வகை', 'CARD - 86xx xxxx xxxx xx78', "", ""),
                ],
              ),
            ),
            Center(
              child: QrImageView(
                data: 'S0000624052100003076',
                version: QrVersions.auto,
                size: 150,
                // gapless: true,
                // embeddedImage: AssetImage(LocalImages().appLogo),
                // embeddedImageStyle: const QrEmbeddedImageStyle(
                //   size: Size(75, 75),
                // ),
              ),
            ),
            Center(
              child: label2('கட்டணமில்லா எண்.-', '1800-425-1757',
                  const EdgeInsets.only(left: 12.0)),
            ),
            const SizedBox(height: 10)
            //Tollfree No. : 1800-425-1757
          ],
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
