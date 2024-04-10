import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:ionicons/ionicons.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/bloc/temple_info/temple_info_bloc.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/bloc/temple_timing/temple_timing_bloc.dart';

import '../../../../injection_container.dart';
import '../../../dashboard/presentation/widgets/service_list.dart';
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
    super.initState();
    BlocProvider.of<TempleInfoBloc>(context)
        .add(GetTempleInfo(templeId: widget.temple!.templeId.toString()));
    BlocProvider.of<TempleTimingBloc>(context)
        .add(GetTempleTiming(templeId: widget.temple!.templeId.toString()));
  }

  @override
  Widget build(BuildContext context) {
    tabController = TabController(length: 3, vsync: this);
    return BlocProvider(
      create: (_) => sl<ITMSBloc>(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    buildTempleImage(context, widget.temple),
                    _buildTempleTitle(context),
                    buildServices(),
                    buildTabBar(context, tabController),
                  ],
                ),
              ),
            ];
          },
          body: buildTabView(context, tabController),
        ),
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

  // Widget _buildBody(context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.stretch,
  //     children: [
  //       buildTempleImage(context, widget.temple),
  //       _buildTempleTitle(context),
  //       buildTabBar(context, tabController),
  //       buildTabView(context, tabController)
  //     ],
  //   );
  // }

  // Widget _buildBody(context) {
  //   return CustomScrollView(
  //     shrinkWrap: true,
  //     slivers: [
  //       SliverToBoxAdapter(
  //         child: buildTempleImage(context, widget.temple),
  //       ),
  //       SliverToBoxAdapter(
  //         child: _buildTempleTitle(context),
  //       ),
  //       SliverToBoxAdapter(
  //         child: buildTabBar(context, tabController),
  //       ),
  //       SliverFillRemaining(
  //         child: buildTabView(context, tabController),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildTempleTitle(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 14),
      child: Text(
        Locales.currentLocale(context)!.languageCode == "en"
            ? widget.temple!.templeName ?? '-'
            : widget.temple!.ttempleName ?? "-",
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

  buildServices() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LocaleText(
            'services',
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary),
          ),
          buildDevoteeServicesList(listType: "HL"),
        ],
      ),
    );
  }
}
