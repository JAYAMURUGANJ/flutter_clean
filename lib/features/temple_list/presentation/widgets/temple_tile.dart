import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:news_app_clean_architecture/config/common/extensions.dart';
import 'package:news_app_clean_architecture/config/common/widgets/parallax_image.dart';

import '../../../../config/common/widgets/network_image_cache.dart';
import '../../../../config/constants.dart';
import '../../domain/entities/itms_response.dart';

class TempleListTile extends StatelessWidget {
  final ItmsResponseEntity? temple;
  final void Function(ItmsResponseEntity article)? onTemplePressed;

  const TempleListTile({
    Key? key,
    this.temple,
    this.onTemplePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildImage(
                context,
                temple!.maintowerImage!.isNotEmpty
                    ? ApiCredentials().documents +
                        temple!.maintowerImage![0].fileLocation.toString()
                    : 'https://cdn-icons-png.freepik.com/512/89/89020.png',
                width: 120),
            _buildTitleAndDescription(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleAndDescription(context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        child: Text(
          Locales.currentLocale(context)!.languageCode == "en"
              ? temple!.templeName ?? '-'
              : temple!.ttempleName ?? "-",
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _onTap() {
    if (onTemplePressed != null) {
      onTemplePressed!(temple!);
    }
  }
}

class MainTempleListTile extends StatelessWidget {
  final ItmsResponseEntity? temple;
  final void Function(ItmsResponseEntity article)? onTemplePressed;

  const MainTempleListTile({
    Key? key,
    this.temple,
    this.onTemplePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey backgroundImageKey = GlobalKey();
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.only(topRight: Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 48, 36, 36).withOpacity(0.4),
                  spreadRadius: 3,
                  blurRadius: 4,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            height: 250,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.only(topRight: Radius.circular(50)),
              child: ParallaxImage(
                imageUrl: temple!.maintowerImage!.isNotEmpty
                    ? ApiCredentials().documents +
                        temple!.maintowerImage![0].fileLocation.toString()
                    : 'https://www.seekpng.com/png/detail/252-2523694_hindu-temple-photo-hindu-temple-illustration.png',
                backgroundImageKey: backgroundImageKey,
              ),
            ),
          ),
          _buildTitleAndDescription(context),
          10.ph,
        ],
      ),
    );
  }

  Widget _buildTitleAndDescription(context) {
    final borderColor = Theme.of(context).colorScheme.primary;
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: borderColor,
        border: Border.all(
          color: borderColor,
          width: 12.0,
        ),
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(100)),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 252, 251, 251).withOpacity(0.4),
            spreadRadius: 3,
            blurRadius: 4,
            offset: const Offset(3, 0), // changes position of shadow
          ),
        ],
      ),
      child: Text(
        temple!.templeName ?? '',
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  void _onTap() {
    if (onTemplePressed != null) {
      onTemplePressed!(temple!);
    }
  }
}
