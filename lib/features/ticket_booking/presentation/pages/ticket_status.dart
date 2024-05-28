// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
              onPressed: _shareTicket,
              icon: const Icon(Icons.share_sharp, color: Colors.white))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: TicketWidget(
                  width: 350,
                  height: 700,
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

  void _shareTicket() {}
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
      alignment: AlignmentDirectional.topEnd,
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            LocalImages().wm,
            width: 280,
            height: 450,
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
                      style: widget.theme.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  LocalImages().tnLogo,
                  height: 40,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Center(
                child: Text(
                  'அருள்மிகு தண்டாயுதபாணி சுவாமி திருக்கோயில், பழனி - 624601',
                  textAlign: TextAlign.center,
                  style: widget.theme.textTheme.bodySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Center(
                child: Text(
                  'அர்ச்சனை டிக்கெட் [₹ 50/-]',
                  textAlign: TextAlign.center,
                  style: widget.theme.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: widget.theme.colorScheme.primary),
                ),
              ),
            ),
            Center(
              child: QrImageView(
                data: 'S0000624052100003076',
                version: QrVersions.auto,
                size: 110,
                // gapless: true,
                // embeddedImage: AssetImage(LocalImages().appLogo),
                // embeddedImageStyle: const QrEmbeddedImageStyle(
                //   size: Size(75, 75),
                // ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, right: 52.0),
                  child: ticketDetailsWidget(
                      'ரசீது எண்', 'S0000624052100003076', "", ""),
                ),
                ticketDetailsWidget('பக்தர்', 'ஜெயமுருகன் ஜெயகுமார்', "", ""),
                ticketDetailsWidget(
                  'தேதி',
                  "${today.day}-${today.month}-${today.year}",
                  'பார்வை நேரம்',
                  '10.00 am - 12.00 pm',
                ),
                5.ph,
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'கட்டணம்\n5 X ₹ 50 = ₹ 250/-',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: widget.theme.colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ticketDetailsWidget(
                    'கட்டணம் வகை', 'UPI - jai******@hdfcbank.com', "", ""),
                ticketDetailsWidget(
                    'வங்கி குறிப்பு எண்', '413018291522', "", ""),
                ticketDetailsWidget(
                    'அடையாளம் எண்', 'AADHAR - 62xx xxxx xxxx xx56', "", ""),
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
