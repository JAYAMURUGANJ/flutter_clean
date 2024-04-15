// ignore_for_file: library_private_types_in_public_api

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app_clean_architecture/config/common/extensions.dart';

import '../../constants.dart';

class CardCarouselWithIndicator extends StatefulWidget {
  const CardCarouselWithIndicator({Key? key}) : super(key: key);

  @override
  _CardCarouselWithIndicatorState createState() =>
      _CardCarouselWithIndicatorState();
}

class _CardCarouselWithIndicatorState extends State<CardCarouselWithIndicator> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: [for (var item in colors) _buildCard(item)],
          options: CarouselOptions(
            height: 80.0,
            viewportFraction: 0.8,
            autoPlay: true,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            colors.length, // Number of cards
            (index) => _buildIndicator(index, colors[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildCard(Color color) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                radius: 35,
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  radius: 33,
                  child: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://hrce.tn.gov.in/demoapp/images/temple_div.png"), //NetworkImage
                    radius: 100,
                  ), //CircleAvatar
                ), //CircleAvatar
              ),
            ),
            3.pw, //CircleAvatar
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    'Heading',
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                1.ph,
                SizedBox(
                  width: 150,
                  child: Text(
                    'The News description is available here.',
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.fade,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator(int index, Color color) {
    return Container(
      width: 7.0,
      height: 7.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentIndex == index ? color : Colors.grey,
      ),
    );
  }
}
