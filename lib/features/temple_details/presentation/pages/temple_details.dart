import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../temple_list/domain/entities/itms_response.dart';
import '../../../temple_list/presentation/bloc/itms/itms_bloc.dart';
import '../bloc/temple_pooja/temple_pooja_bloc.dart';
import '../widgets/app_bar.dart';
import '../widgets/tab_widget.dart';
import '../widgets/temple_image.dart';
import '../widgets/temple_services.dart';
import '/features/temple_details/presentation/bloc/temple_info/temple_info_bloc.dart';
import '/features/temple_details/presentation/bloc/temple_timing/temple_timing_bloc.dart';
import '/injection_container.dart';

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
    BlocProvider.of<TemplePoojaBloc>(context)
        .add(GetTemplePooja(templeId: widget.temple!.templeId.toString()));
  }

  @override
  Widget build(BuildContext context) {
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    return BlocProvider(
      create: (_) => sl<ITMSBloc>(),
      child: SafeArea(
        child: Scaffold(
          appBar: appBar(context, widget.temple),
          body: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      buildTempleImage(context, widget.temple!),
                      buildTempleServices(context, widget.temple),
                      buildTabBar(context, tabController),
                    ],
                  ),
                ),
              ];
            },
            body: buildTabView(context, tabController),
          ),
        ),
      ),
    );
  }
}
