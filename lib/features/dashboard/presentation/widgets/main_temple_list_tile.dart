import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../../../temple_list/domain/entities/temple_list.dart';
import '/config/common/extensions.dart';
import '/config/common/widgets/parallax_image.dart';
import '/config/constants.dart';

class MainTempleListTile extends StatelessWidget {
  final TempleEntity? temple;
  final void Function(TempleEntity article)? onTemplePressed;

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
                  const BorderRadius.only(topRight: Radius.circular(40)),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 48, 36, 36).withOpacity(0.4),
                  spreadRadius: 3,
                  blurRadius: 4,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            height: 180,
            width: double.infinity,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.only(topRight: Radius.circular(40)),
              child: ParallaxImage(
                imageUrl: temple!.maintowerImage!.isNotEmpty
                    ? ApiCredentials().documents +
                        temple!.maintowerImage![0].fileLocation.toString()
                    : LocalImages().templePlaceHolder,
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
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
        color: borderColor,
        border: Border.all(
          color: borderColor,
          width: 12.0,
        ),
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(50)),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 252, 251, 251).withOpacity(0.4),
            spreadRadius: 3,
            blurRadius: 4,
            offset: const Offset(3, 0), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: Text(
          Locales.lang == "en"
              ? temple!.templeName ?? '-'
              : temple!.ttempleName ?? "-",
          maxLines: 3,
          overflow: TextOverflow.fade,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
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
