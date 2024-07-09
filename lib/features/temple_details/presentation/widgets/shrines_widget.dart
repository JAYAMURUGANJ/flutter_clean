import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/config/common/extensions.dart';
import 'package:news_app_clean_architecture/config/common/pages/error/something_went_wrong_screen.dart';
import 'package:news_app_clean_architecture/features/temple_details/domain/entities/shrines_details.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/bloc/shrines_details/shrines_bloc.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/widgets/image_desc_widget.dart';
import 'package:news_app_clean_architecture/features/temple_list/domain/entities/temple_list.dart';

import '../../../../config/constants.dart';

class ShrinesWidget extends StatefulWidget {
  final TempleEntity? templeData;
  const ShrinesWidget({Key? key, this.templeData}) : super(key: key);

  @override
  State<ShrinesWidget> createState() => _ShrinesWidgetState();
}

class _ShrinesWidgetState extends State<ShrinesWidget> {
  late PageController _shrinesPageController;
  ValueNotifier<int> currentIndex = ValueNotifier(0);

  @override
  void initState() {
    _shrinesPageController = PageController(
      initialPage: 0,
      keepPage: true,
    );
    BlocProvider.of<ShrinesBloc>(context)
        .add(GetShrinesEvent(templeId: widget.templeData!.templeId.toString()));
    super.initState();
  }

  @override
  void dispose() {
    _shrinesPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ShrinesBloc, ShrinesState>(
        builder: (context, state) {
          if (state is ShrinesLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (state is ShrinesLoadingError) {
            return ErrorWidget(state.error.toString());
          }
          if (state is ShrinesLoadingSomthingWentWrong) {
            return SomethingWentWrong(
              error: state.responseStatus!,
              errorIcon: LocalImages().noDataAvailable,
            );
          }
          if (state is ShrinesLoaded) {
            List<ShrinesDetailsEntity> shrinesList =
                state.shrines!.cast<ShrinesDetailsEntity>();

            ///===>
            return PageView.builder(
                controller: _shrinesPageController,
                itemCount: shrinesList.length,
                itemBuilder: (context, index) {
                  return ImageDescPageViewer(
                    pageController: _shrinesPageController,
                    imageUrl: shrinesList[index].subshrineImage!.isNotEmpty
                        ? ApiCredentials.filePath! +
                            shrinesList[index].subshrineImage![0].fileLocation!
                        : LocalImages().templePlaceHolder,
                    name: shrinesList[index].subshrineName,
                    desc: shrinesList[index].subshrineDesc,
                    length: shrinesList.length,
                    index: index,
                  );
                });
          }
          return 0.pw;
        },
      ),
    );
  }
}
