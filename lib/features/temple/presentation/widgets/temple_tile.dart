import 'package:flutter/material.dart';

import '../../../../config/common/widgets/network_image_cache.dart';
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
        padding: const EdgeInsetsDirectional.only(
            start: 14, end: 14, bottom: 7, top: 7),
        height: MediaQuery.of(context).size.width / 2.2,
        child: Row(
          children: [
            buildImage(
                context,
                temple!.maintowerImage!.isNotEmpty
                    ? 'https://hrce.tn.gov.in/webservice/documentview.php?file_path=${temple!.maintowerImage![0].fileLocation}'
                    : 'https://cdn-icons-png.freepik.com/512/89/89020.png'),
            _buildTitleAndDescription(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleAndDescription() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              temple!.templeName ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Butler',
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),

            // Description
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  temple!.ttempleName ?? '',
                  maxLines: 2,
                ),
              ),
            ),

            // Datetime
            Row(
              children: [
                const Icon(Icons.timeline_outlined, size: 16),
                const SizedBox(width: 4),
                Text(
                  temple!.templeId!.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
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
