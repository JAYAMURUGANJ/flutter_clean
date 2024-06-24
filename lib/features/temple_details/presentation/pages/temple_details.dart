import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/bloc/speciality/speciality_bloc.dart';

import '../../../temple_list/domain/entities/temple_list.dart';
import '../../../temple_list/presentation/bloc/temple_list/temple_list_bloc.dart';
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
  final TempleListEntity? temple;

  const TempleDetailsView({Key? key, this.temple}) : super(key: key);

  @override
  State<TempleDetailsView> createState() => _TempleDetailsViewState();
}

class _TempleDetailsViewState extends State<TempleDetailsView>
    with TickerProviderStateMixin {
  late TabController tabController;
  late AnimationController _buttonAnimationController;
  late Animation<Color?> _colorAnimation;
  @override
  void initState() {
    _buttonAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _buttonAnimationController.repeat(reverse: true);
    _colorAnimation = ColorTween(
      begin: Colors.amber,
      end: Colors.purple,
    ).animate(_buttonAnimationController);

    super.initState();
    BlocProvider.of<TempleInfoBloc>(context)
        .add(GetTempleInfo(templeId: widget.temple!.templeId.toString()));
    BlocProvider.of<TempleTimingBloc>(context)
        .add(GetTempleTiming(templeId: widget.temple!.templeId.toString()));
    BlocProvider.of<TemplePoojaBloc>(context)
        .add(GetTemplePooja(templeId: widget.temple!.templeId.toString()));
    BlocProvider.of<SpecialityBloc>(context)
        .add(GetSpeciality(templeId: widget.temple!.templeId.toString()));
  }

  @override
  void dispose() {
    _buttonAnimationController.dispose();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    return BlocProvider(
      create: (_) => sl<TempleListBloc>(),
      child: SafeArea(
        child: Scaffold(
          appBar: appBar(context, widget.temple),
          body: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      buildTempleImage(context, widget.temple!,
                          _buttonAnimationController, _colorAnimation),
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
