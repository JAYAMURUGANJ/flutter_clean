import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/bloc/temple_info/temple_info_bloc.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/bloc/temple_timing/temple_timing_bloc.dart';

import '../../../../config/common/widgets/app_header.dart';
import '../../../../config/constants.dart';
import '../../../../injection_container.dart';
import '../../../dashboard/presentation/widgets/service_list.dart';
import '../../../temple_list/domain/entities/itms_response.dart';
import '../../../temple_list/presentation/bloc/itms/itms_bloc.dart';
import '../bloc/temple_pooja/temple_pooja_bloc.dart';
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
    BlocProvider.of<TemplePoojaBloc>(context)
        .add(GetTemplePooja(templeId: widget.temple!.templeId.toString()));
  }

  @override
  Widget build(BuildContext context) {
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    return BlocProvider(
      create: (_) => sl<ITMSBloc>(),
      child: Scaffold(
        appBar: appHeader(
            context: context,
            leadingAvail: false,
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                Locales.lang == "en"
                    ? widget.temple!.templeName ?? '-'
                    : widget.temple!.ttempleName ?? "-",
                softWrap: true,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
            trailing: const Icon(Icons.language)),
        body: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    buildTempleImage(context, widget.temple),
                    buildServices(context),
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
}

onBackButtonTapped(BuildContext context) {
  Navigator.pop(context);
}

buildServices(context) {
  return Padding(
    padding: defaultPadding,
    child: buildDevoteeServicesList(listType: "HL"),
  );
}
