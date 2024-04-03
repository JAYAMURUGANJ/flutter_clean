import 'package:flutter/material.dart';

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
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: SizedBox(
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildImage(
                context,
                temple!.maintowerImage!.isNotEmpty
                    ? ApiCredentials().documents +
                        temple!.maintowerImage![0].fileLocation.toString()
                    : 'https://cdn-icons-png.freepik.com/512/89/89020.png',
              ),
              _buildTitleAndDescription(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndDescription(context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              temple!.templeName ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ],
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
