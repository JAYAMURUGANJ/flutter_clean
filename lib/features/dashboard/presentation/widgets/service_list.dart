import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../../../../config/constants.dart';

buildDevoteeServicesList({required String listType}) {
  return listType != 'GRID'
      ? SizedBox(
          height: 130,
          child: ListView.builder(
            padding: const EdgeInsets.only(right: 3),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemExtent: 90,
            itemCount: bookingServicesList.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {},
              child: _devoteeServiceCard(index, context, 100, 80, 14),
            ),
          ),
        )
      : GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // number of items in each row
            mainAxisSpacing: 8.0, // spacing between rows
            crossAxisSpacing: 8.0, // spacing between columns
          ),
          padding: const EdgeInsets.all(8.0), // padding around the grid
          itemCount: bookingServicesList.length, // total number of items
          itemBuilder: (context, index) {
            return _devoteeServiceCard(index, context, 130, 120, 18);
          },
        );
}

Column _devoteeServiceCard(int index, BuildContext context, double width,
    double height, double fontSize) {
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.all(12),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: bookingServicesList[index].bgColor,
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
            bookingServicesList[index].imageLink!,
          ),

          // Text(
          //   bookingServicesList[index].emoji!,
          //   style: const TextStyle(fontSize: 35),
          //   textAlign: TextAlign.center,
          // )
          // Image(image: AssetImage(bookingServicesList[index].imageLink!)),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: LocaleText(
          bookingServicesList[index].name!,
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
  );
}
