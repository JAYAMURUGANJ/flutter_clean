import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import '../../../../config/constants.dart';
import '../../domain/entities/speciality.dart';

class SpecialityWidget extends StatefulWidget {
  final List<SpecialityEntity> specialityList;
  const SpecialityWidget({Key? key, required this.specialityList})
      : super(key: key);

  @override
  State<SpecialityWidget> createState() => _SpecialityWidgetState();
}

class _SpecialityWidgetState extends State<SpecialityWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.specialityList.length,
      itemBuilder: (context, index) {
        return CachedNetworkImage(
          placeholder: (context, url) => const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: CupertinoActivityIndicator(),
          ),
          imageUrl: widget.specialityList[index].specialityImage!.isNotEmpty
              ? ApiCredentials().documents +
                  widget.specialityList[index].specialityImage![0].fileLocation
                      .toString()
              : NetworkImages.templePlaceHolder,
          fit: BoxFit.cover,
        );
      },
    );
  }
}
