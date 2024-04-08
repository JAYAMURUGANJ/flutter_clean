import 'package:flutter/material.dart';

import '../../../../config/constants.dart';

buildServicesList() {
  return SizedBox(
    height: 130,
    child: ListView.builder(
      padding: const EdgeInsets.only(right: 3),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemExtent: 90,
      itemCount: bookingServicesList.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {},
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(12),
              width: 100,
              height: 80,
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

              //  color: Colors.white,
              //  borderRadius: BorderRadius.circular(16),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                bookingServicesList[index].name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
