import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../../domain/entities/temple_list_response.dart';
import '/config/common/extensions.dart';
import '/config/common/widgets/network_image_cache.dart';
import '/config/constants.dart';

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
                  : NetworkImages.templePlaceHolder,
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
              ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  )
              : Theme.of(context).textTheme.bodySmall!.copyWith(
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
