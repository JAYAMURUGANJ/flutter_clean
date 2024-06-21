import 'dart:io' show Platform;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';
import '/config/common/extensions.dart';

class AppReferalCard extends StatelessWidget {
  const AppReferalCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var playStoreId = "com.mslabs.thirukoil&hl=en-IN";
    // var appStoreId = "1663719013";

    return GestureDetector(
      onTap: () async {
        debugPrint("ReferralCard");
        var playStoreId = "com.mslabs.thirukoil";
        var appStoreId = "1663719013";
        final url = Uri.parse(
          Platform.isAndroid
              ? "market://details?id=$playStoreId"
              : "https://apps.apple.com/app/id$appStoreId",
        );

        debugPrint("Launching URL: $url");

        if (await canLaunchUrl(url)) {
          await launchUrl(
            url,
            mode: LaunchMode.externalApplication,
          );
        } else {
          debugPrint("Could not launch $url");
        }
      },
      child: Padding(
        padding: defaultPadding,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              width: 350,
              height: 120.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary,
                    const Color.fromARGB(95, 252, 251, 251).withOpacity(0.5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 215,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LocaleText(
                          "refer_a_devotee",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                        ),
                        2.ph,
                        LocaleText(
                          "referal_description",
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  color: Colors.white,
                                  fontSize: 12,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 38,
                    child: Image(
                      image: ExactAssetImage(
                        LocalImages().logo,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
