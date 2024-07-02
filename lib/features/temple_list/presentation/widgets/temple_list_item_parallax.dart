import 'package:flutter/material.dart';

import '../../../../config/common/widgets/parallax_image.dart';
import '../../../../config/constants.dart';
import '../../domain/entities/temple_list.dart';

class TempleListItem extends StatelessWidget {
  TempleListItem({
    Key? key,
    this.temple,
    this.onTemplePressed,
  }) : super(key: key);

  final TempleEntity? temple;
  final void Function(TempleEntity article)? onTemplePressed;
  final GlobalKey _backgroundImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    String imageUrl = temple!.maintowerImage!.isNotEmpty
        ? ApiCredentials.filePath! +
            temple!.maintowerImage![0].fileLocation.toString()
        : 'https://pics.craiyon.com/2023-07-04/d2196b89b47448e3aa40073992249187.webp';
    String? templeName = temple!.templeName;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                _buildParallaxBackground(context, imageUrl),
                _buildGradient(),
                _buildTitleAndSubtitle(templeName!, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildParallaxBackground(BuildContext context, String imageUrl) {
    return ParallaxImage(
        backgroundImageKey: _backgroundImageKey, imageUrl: imageUrl);
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.6, 0.95],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndSubtitle(String templeName, context) {
    return Positioned(
      left: 10,
      bottom: 10,
      right: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context)
                .size
                .width, //this is the total width of your screen

            child: Text(
              templeName,
              maxLines: 3,
              overflow: TextOverflow.clip,
              softWrap: true,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Text(
          //   country,
          //   style: const TextStyle(
          //     color: Colors.white,
          //     fontSize: 14,
          //   ),
          // ),
        ],
      ),
    );
  }

  void _onTap() {
    if (onTemplePressed != null) {
      onTemplePressed!(temple!);
    }
  }
}
