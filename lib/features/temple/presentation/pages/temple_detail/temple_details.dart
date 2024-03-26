import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../config/common/widgets/network_image_cache.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/temple.dart';
import '../../bloc/temple/remote/temple_list_bloc.dart';
import '/config/common/extensions.dart';

class TempleDetailsView extends StatelessWidget {
  final TempleEntity? temple;

  const TempleDetailsView({Key? key, this.temple}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TempleListBloc>(),
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
          child: const Icon(Ionicons.chevron_back, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildArticleTitleAndDate(),
          buildImage(
              context,
              temple!.maintowerImage![0].fileLocation!.isUrl()
                  ? temple!.maintowerImage![0].fileLocation!
                  : 'https://hrce.tn.gov.in/webservice/documentview.php?file_path=${temple!.maintowerImage![0].fileLocation}'),
          _buildArticleDescription(),
        ],
      ),
    );
  }

  Widget _buildArticleTitleAndDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            temple!.templeName!,
            style: const TextStyle(
                fontFamily: 'Butler',
                fontSize: 20,
                fontWeight: FontWeight.w900),
          ),

          const SizedBox(height: 14),
          // DateTime
          const Row(
            children: [
              Icon(Ionicons.time_outline, size: 16),
              SizedBox(width: 4),
              Text(
                " temple!.jurisOfficeCode!.toString()",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildArticleDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      child: Text(
        '${temple!.templeName ?? ''}\n\n${temple!.ttempleName ?? ''}',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }
}
