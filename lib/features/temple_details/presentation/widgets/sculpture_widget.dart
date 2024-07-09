import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/common/extensions.dart';
import '/config/common/pages/error/something_went_wrong_screen.dart';
import '/config/constants.dart';
import '/features/temple_details/domain/entities/sculpture.dart';
import '/features/temple_details/presentation/bloc/sculptures/sculptures_bloc.dart';
import '/features/temple_details/presentation/widgets/image_desc_widget.dart';
import '../../../temple_list/domain/entities/temple_list.dart';

class SculpturesWidget extends StatefulWidget {
  final TempleEntity? templeData;
  const SculpturesWidget({Key? key, this.templeData}) : super(key: key);

  @override
  State<SculpturesWidget> createState() => _SculpturesWidgetState();
}

class _SculpturesWidgetState extends State<SculpturesWidget> {
  final PageController _sculpturePageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  @override
  void initState() {
    BlocProvider.of<SculpturesBloc>(context).add(
        GetSculpturesEvent(templeId: widget.templeData!.templeId.toString()));
    super.initState();
  }

  @override
  void dispose() {
    _sculpturePageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SculpturesBloc, SculpturesState>(
        builder: (context, state) {
      if (state is SculpturesLoading) {
        return const Center(child: CupertinoActivityIndicator());
      }
      if (state is SculpturesLoadingError) {
        return ErrorWidget(state.error.toString());
      }
      if (state is SculpturesLoadingSomthingWentWrong) {
        return SomethingWentWrong(
          error: state.responseStatus!,
          errorIcon: LocalImages().noDataAvailable,
        );
      }
      if (state is SculpturesLoaded) {
        List<SculptureEntity> sculpturesList =
            state.sculptures!.cast<SculptureEntity>();
        return PageView.builder(
            controller: _sculpturePageController,
            itemCount: sculpturesList.length,
            itemBuilder: (context, index) {
              return ImageDescPageViewer(
                pageController: _sculpturePageController,
                imageUrl: sculpturesList[index].sculptureInfo!.isNotEmpty
                    ? ApiCredentials.filePath! +
                        sculpturesList[index].sculptureInfo![0].fileLocation!
                    : LocalImages().templePlaceHolder,
                name: sculpturesList[index].sculpturesName ?? "",
                desc: sculpturesList[index].sculptureDesc ?? "",
                length: sculpturesList.length,
                index: index,
              );
              //
            });
      }
      return 0.pw;
    });
  }
}
