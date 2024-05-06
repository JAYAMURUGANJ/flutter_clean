import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../../../../config/common/widgets/network_image_cache.dart';
import '../../../../config/constants.dart';
import '../../domain/entities/itms_response.dart';
import '/config/common/extensions.dart';

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
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildImage(
              context,
              temple!.maintowerImage!.isNotEmpty
                  ? ApiCredentials().documents +
                      temple!.maintowerImage![0].fileLocation.toString()
                  : 'https://cdn-icons-png.freepik.com/512/89/89020.png',
              width: 90,
              height: 90,
            ),
            5.pw,
            _buildTitleAndDescription(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleAndDescription(context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          Locales.lang == "en" ? temple!.templeName! : temple!.ttempleName!,
          maxLines: 5,
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: Locales.lang == "en"
              ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  )
              : Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
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
      child: Container(
          margin: const EdgeInsets.only(bottom: 32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 48, 36, 36).withOpacity(0.4),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            image: DecorationImage(
                image: Image.network(
                  temple!.maintowerImage!.isNotEmpty
                      ? ApiCredentials().documents +
                          temple!.maintowerImage![0].fileLocation.toString()
                      : 'https://www.seekpng.com/png/detail/252-2523694_hindu-temple-photo-hindu-temple-illustration.png',
                ).image,
                fit: BoxFit.cover),
          ),
          height: 280,
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black87],
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32)),
            ),
            child: Text(
              Locales.lang == "en"
                  ? temple!.templeName ?? '-'
                  : temple!.ttempleName ?? "-",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          )

          //  Stack(
          //   alignment: Alignment.topCenter,
          //   children: [
          //     ClipRRect(
          //        borderRadius: BorderRadius.circular(18),
          //       child: ParallaxImage(
          //         imageUrl: temple!.maintowerImage!.isNotEmpty
          //             ? ApiCredentials().documents +
          //                 temple!.maintowerImage![0].fileLocation.toString()
          //             : 'https://www.seekpng.com/png/detail/252-2523694_hindu-temple-photo-hindu-temple-illustration.png',
          //         backgroundImageKey: backgroundImageKey,
          //       ),
          //     ),
          //     Positioned(
          //         bottom: 10,
          //         child: Text(
          //           Locales.lang == "en"
          //               ? temple!.templeName ?? '-'
          //               : temple!.ttempleName ?? "-",
          //           style: Theme.of(context).textTheme.titleLarge!.copyWith(
          //               color: Colors.white, fontWeight: FontWeight.bold),
          //         )),
          //   ],
          // ),
          ),
    );
  }

  void _onTap() {
    if (onTemplePressed != null) {
      onTemplePressed!(temple!);
    }
  }
}
