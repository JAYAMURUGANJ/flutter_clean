import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:news_app_clean_architecture/config/common/widgets/app_logo.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/widgets/main_tower.dart';

import '../../../../config/constants.dart';
import '../../../temple_list/domain/entities/itms_response.dart';

//Temple contact information
buildContactBottomSheet(context, ItmsResponseEntity temple) {
  return showModalBottomSheet(
    isScrollControlled: true,
    isDismissible: false,
    context: context,
    builder: (context) {
      return MediaQuery(
        data: MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.first),
        child: Scaffold(
          appBar: AppBar(
            
            elevation: 0,
            leading: const AppIcon(height: 50),
            actions: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ],
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: LocaleText(
              "contact",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.white),
            ),
          ),
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.white,
                      Theme.of(context).colorScheme.primary.blend(Colors.white),
                    ],
                  ),
                ),
                height: MediaQuery.sizeOf(context).height / 3,
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        Locales.lang == "en"
                            ? temple.templeName ?? '-'
                            : temple.ttempleName ?? "-",
                        softWrap: true,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                      ),
                    ),
                    mainTower(temple, 80),
                    buildContactCard(context, "designation", "Incharge Name",
                        Icons.contact_emergency, () {}),
                    buildContactCard(context, "address", "Temple Address",
                        Icons.location_on_outlined, () {}),
                    buildContactCard(context, "email", "temple@example.com",
                        Icons.mail_outline, () {}),
                    buildContactCard(context, "phone", "9876543210",
                        Icons.phone_outlined, () {}),
                    buildContactCard(context, "website", "click to go",
                        Icons.language, () {}),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

buildContactCard(BuildContext context, String lable, String value,
    IconData icon, VoidCallback action,
    {bool localLable = true}) {
  return Padding(
    padding: defaultPadding,
    child: ListTile(
      onTap: action,
      trailing: IconButton(
        icon: Icon(icon),
        highlightColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        hoverColor: Colors.white,
        onPressed: action,
      ),
      title: localLable
          ? LocaleText(
              lable,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
            )
          : Text(
              "Designation for Temple Inchager",
              softWrap: true,
              maxLines: 2,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
      subtitle: Text(
        value,
        maxLines: 2,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontWeight: FontWeight.w500),
      ),
    ),
  );
}
