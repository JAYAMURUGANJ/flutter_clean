import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/config/common/extensions.dart';
import 'package:news_app_clean_architecture/config/common/pages/error/something_went_wrong_screen.dart';
import 'package:news_app_clean_architecture/features/temple_details/domain/entities/shrines_details.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/bloc/shrines_details/shrines_bloc.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/widgets/image_desc_widget.dart';
import 'package:news_app_clean_architecture/features/temple_list/domain/entities/itms_response.dart';
import '../../../../config/constants.dart';

class ShrinesWidget extends StatefulWidget {
  final ItmsResponseEntity? templeData;
  const ShrinesWidget({Key? key, this.templeData}) : super(key: key);

  @override
  State<ShrinesWidget> createState() => _ShrinesWidgetState();
}

class _ShrinesWidgetState extends State<ShrinesWidget> {
  final PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  ValueNotifier<int> currentIndex = ValueNotifier(0);
  final ScrollController _mainScrollController = ScrollController();
  final ScrollController _descriptionScrollController = ScrollController();
  final ValueNotifier<bool> _scrollDesc = ValueNotifier(false);

  @override
  void initState() {
    BlocProvider.of<ShrinesBloc>(context)
        .add(GetShrinesEvent(templeId: widget.templeData!.templeId.toString()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _mainScrollController.addListener(_mainScrollListener);
    });
  }

  void _mainScrollListener() {
    if (_mainScrollController.offset >=
        MediaQuery.of(context).size.height * .19) {
      if (_descriptionScrollController.position.userScrollDirection ==
              ScrollDirection.forward &&
          _descriptionScrollController.offset <= 0.0) {
        _scrollDesc.value = false;
      } else {
        _scrollDesc.value = true;
      }
    } else {
      _scrollDesc.value = false;
    }
  }

  @override
  void dispose() {
    _mainScrollController.removeListener(_mainScrollListener);
    _mainScrollController.dispose();
    _descriptionScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShrinesBloc, ShrinesState>(
      builder: (context, state) {
        if (state is ShrinesLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is ShrinesLodingError) {
          return ErrorWidget(state.error.toString());
        }
        if (state is ShrinesLoadingSomthingWentWrong) {
          return SomethingWentWrong(error: state.error.toString());
        }
        if (state is ShrinesLoaded) {
          List<ShrinesDetailsEntity> shrinesList =
              state.shrines!.cast<ShrinesDetailsEntity>();

          ///===>
          return PageView.builder(
              controller: _pageController,
              itemCount: shrinesList.length,
              itemBuilder: (context, index) {
                return ImageDescWidget(
                    pageController: _pageController,
                    imageUrl: shrinesList[index].subshrineImage!.isNotEmpty
                        ? ApiCredentials().documents +
                            shrinesList[index].subshrineImage![0].fileLocation!
                        : NetworkImages.templePlaceHolder,
                    name: shrinesList[index].subshrineName,
                    desc: shrinesList[index].subshrineDesc);
              });
        }
        return 0.pw;
      },
    );
  }
}
