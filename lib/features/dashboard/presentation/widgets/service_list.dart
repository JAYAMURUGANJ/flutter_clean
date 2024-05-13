// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:news_app_clean_architecture/config/common/widgets/bottom_sheet.dart';
import 'package:news_app_clean_architecture/features/event_calendar/presentation/pages/event_calendar.dart';

import '../../../../config/common/widgets/text_widgets.dart';
import '../../../../config/constants.dart';
import '../../../../core/models/booking_services.dart';
import '../../../temple_list/domain/entities/itms_response.dart';

buildTempleServicesList(
    {required String listType,
    required List<TempleServices> services,
    ItmsResponseEntity? templeData}) {
  return listType != 'GRID'
      ? SizedBox(
          height: Locales.lang == "en" ? 100 : 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemExtent: 90,
            itemCount: services.length,
            itemBuilder: (context, index) => _serviceCard(
                index, services, context, 100, 60, 12, "CIRCLE", templeData),
          ),
        )
      : GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // number of items in each row
            mainAxisSpacing: 8.0, // spacing between rows
            crossAxisSpacing: 8.0, // spacing between columns
          ),
          padding: const EdgeInsets.all(8.0), // padding around the grid
          itemCount: services.length, // total number of items
          itemBuilder: (context, index) {
            return _serviceCard(
                index, services, context, 100, 100, 16, "RECT", templeData);
          },
        );
}

_serviceCard(
    int index,
    List<TempleServices> services,
    BuildContext context,
    double width,
    double height,
    double fontSize,
    String cardType,
    ItmsResponseEntity? templeData) {
  return GestureDetector(
    onTap: services[index].isBottomSheet!
        ? () => buildBottomSheet(context, templeData, services[index].name!,
            TempleEventCalendar(templeData: templeData))
        : services[index].page.toString().isNotEmpty
            ? () => pageNavigation(services[index].page.toString(), context)
            : () {
                debugPrint(services[index].page.toString());
              },
    child: Column(
      children: [
        cardType == "RECT"
            ? Container(
                margin: const EdgeInsets.all(10),
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: services[index].bgColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    services[index].imageLink!,
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: CircleAvatar(
                  backgroundColor: services[index].bgColor,
                  radius: 35,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      services[index].imageLink!,
                    ),
                  ),
                ),
              ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: LocaleText(
            services[index].name!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.bold, fontSize: fontSize),
          ),
        ),
      ],
    ),
  );
}

pageNavigation(String routeName, BuildContext context) {
  return routeName != "" ? Navigator.pushNamed(context, routeName) : () {};
}

popAndPushNamedNavigation(String routeName, BuildContext context) {
  return routeName != ""
      ? Navigator.pushReplacementNamed(context, routeName)
      : () {};
}

buildDevoteeServiceList(context) {
  return Padding(
    padding: defaultPadding,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildHeading(context, "devotee_services"),
        buildTempleServicesList(listType: 'HL', services: bookingServicesList)
      ],
    ),
  );
}

otherServiceList(BuildContext context) {
  List<Widget> children = List.generate(otherServicesList.length,
      (e) => otherServiceCard(e, context, 80, 80, 12, otherServicesList));
  return Padding(
    padding: defaultPadding,
    child: Wrap(
      spacing: 15.0,
      children: children,
    ),
  );
}

otherServiceCard(int index, BuildContext context, double width, double height,
    double fontSize, List listName) {
  return GestureDetector(
    onTap: listName[index].page.toString().isNotEmpty
        ? () {
            if (listName == drawerList) {
              popAndPushNamedNavigation(
                  listName[index].page.toString(), context);
            } else {
              pageNavigation(listName[index].page.toString(), context);
            }
          }
        : () {
            debugPrint(listName[index].page.toString());
          },
    child: Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: listName[index].bgColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              listName[index].imageLink!,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: LocaleText(
            listName[index].name!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.bold, fontSize: fontSize),
          ),
        ),
      ],
    ),
  );
}
