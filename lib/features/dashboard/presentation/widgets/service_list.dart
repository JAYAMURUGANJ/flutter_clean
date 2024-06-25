// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/widgets/sculpture_widget.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/widgets/shrines_widget.dart';

import '../../../event_calendar/presentation/pages/event_calendar.dart';
import '../../../temple_list/domain/entities/temple_list.dart';
import '../pages/live_telecast.dart';
import '/config/common/widgets/bottom_sheet.dart';
import '/config/common/widgets/no_data_available.dart';
import '/config/common/widgets/text_widgets.dart';
import '/config/constants.dart';
import '/core/models/booking_services.dart';
import '/features/dashboard/presentation/bloc/current_location/current_location_bloc.dart';

buildTempleServicesList(
    {required String listType,
    required List<TempleServices> services,
    TempleEntity? templeData}) {
  return listType != 'GRID'
      ? SizedBox(
          height: Locales.lang == "en" ? 100 : 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemExtent: 90,
            itemCount: services.length,
            itemBuilder: (context, index) => _serviceCard(
                index, services, context, 100, 60, 11, "CIRCLE", templeData),
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
                index, services, context, 100, 100, 12, "RECT", templeData);
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
    TempleEntity? templeData) {
  return GestureDetector(
    onTap: services[index].isBottomSheet!
        ? () {
            switch (services[index].id) {
              case 1:
                {
                  pageNavigation("/Facility", context,
                      arguments: templeData as TempleEntity);
                }
                break;
              case 3:
                {
                  buildBottomSheet(context, templeData, services[index].name!,
                      SculpturesWidget(templeData: templeData));
                }
                break;
              case 4:
                {
                  buildBottomSheet(
                    context,
                    templeData,
                    services[index].name!,
                    ShrinesWidget(templeData: templeData),
                  );
                }
                break;
              case 5:
                {
                  buildBottomSheet(context, templeData, services[index].name!,
                      TempleLiveTeleCasts(templeData: templeData));
                }
                break;
              case 6:
                {
                  buildBottomSheet(context, templeData, services[index].name!,
                      TempleEventCalendar(templeData: templeData));
                }
                break;
              default:
                {
                  DataNotAvailable(
                      error: "live_telecasting_not_available",
                      img: NetworkImages.noLiveAvailable);
                }
                break;
            }
          }
        : services[index].page.toString().isNotEmpty
            ? () => pageNavigation(services[index].page.toString(), context)
            : () {},
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

pageNavigation(String routeName, BuildContext context, {Object? arguments}) {
  return routeName != ""
      ? Navigator.pushNamed(context, routeName, arguments: arguments)
      : () {};
}

popAndPushNamedNavigation(String routeName, BuildContext context,
    {Object? arguments}) {
  return routeName != ""
      ? Navigator.pushReplacementNamed(context, routeName, arguments: arguments)
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
    double fontSize, List<TempleServices> listName) {
  return GestureDetector(
    onTap: listName[index].page.toString().isNotEmpty
        ? () {
            if (listName == drawerList) {
              popAndPushNamedNavigation(
                  listName[index].page.toString(), context);
            } else {
              if (listName[index].name == "near_by_temples") {
                BlocProvider.of<CurrentLocationBloc>(context)
                    .add(GetCurrentLocation(listName[index].page!));
              } else {
                pageNavigation(listName[index].page.toString(), context);
              }
            }
          }
        : () {},
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
