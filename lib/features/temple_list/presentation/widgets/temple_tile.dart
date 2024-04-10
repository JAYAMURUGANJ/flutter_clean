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
          temple!.templeName ?? '',
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _onTap,
        child: Container(
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
          child: Stack(
            children: [
              CircleAvatar(
                child: buildImage(
                  context,
                  temple!.maintowerImage!.isNotEmpty
                      ? ApiCredentials().documents +
                          temple!.maintowerImage![0].fileLocation.toString()
                      : 'https://cdn-icons-png.freepik.com/512/89/89020.png',
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: _buildTitleAndDescription(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndDescription(context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        child: Text(
          temple!.templeName ?? '',
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
