import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/bloc/temple_details/temple_info_bloc.dart';
import '../../../../injection_container.dart';
import '../../../temple_list/domain/entities/itms_response.dart';
import '../../../temple_list/presentation/bloc/itms/itms_bloc.dart';
import '../widgets/tab_widget.dart';
import '../widgets/temple_image.dart';

TabController? tabController;

class TempleDetailsView extends StatefulWidget {
  final ItmsResponseEntity? temple;

  const TempleDetailsView({Key? key, this.temple}) : super(key: key);

  @override
  State<TempleDetailsView> createState() => _TempleDetailsViewState();
}

class _TempleDetailsViewState extends State<TempleDetailsView>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    BlocProvider.of<TempleInfoBloc>(context)
        .add(GetTempleInfo(templeId: widget.temple!.templeId.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    tabController = TabController(length: 3, vsync: this);
    return BlocProvider(
      create: (_) => sl<ITMSBloc>(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onBackButtonTapped(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                const Icon(Ionicons.chevron_back, color: Colors.black),
                Text(
                  "Back",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.start,
                )
              ],
            ),
          ),
        ),
      ),
      leadingWidth: 100,
    );
  }

  Widget _buildBody(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildTempleImage(context, widget.temple),
        _buildTempleTitle(context),
        buildTabBar(context, tabController),
        buildTabView(context, tabController)
      ],
    );
  }

  Widget _buildTempleTitle(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 14),
      child: Text(
        widget.temple!.templeName ?? '',
        style: const TextStyle(
          fontFamily: 'Butler',
          fontSize: 18,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }
}
