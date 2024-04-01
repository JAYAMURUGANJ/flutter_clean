import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:news_app_clean_architecture/config/common/extensions.dart';

import '../../../../../config/common/widgets/network_image_cache.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/itms_response.dart';
import '../../bloc/itms/itms_bloc.dart';

class TempleDetailsView extends StatelessWidget {
  final ItmsResponseEntity? temple;

  const TempleDetailsView({Key? key, this.temple}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: const Icon(Ionicons.chevron_back, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildTempleTitleAndDate(),
          _buildTempleImage(context, temple),
          _buildTempleDescription(),
        ],
      ),
    );
  }

  Widget _buildTempleImage(context, temple) {
    return Container(
      width: double.maxFinite,
      height: 250,
      margin: const EdgeInsets.only(top: 14),
      child: buildImage(
          context,
          temple!.maintowerImage!.isNotEmpty
              ? 'https://hrce.tn.gov.in/webservice/documentview.php?file_path=${temple!.maintowerImage![0].fileLocation}'
              : 'https://cdn-icons-png.freepik.com/512/89/89020.png'),
    );
  }

  Widget _buildTempleTitleAndDate() {
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

          14.ph,
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

  Widget _buildTempleDescription() {
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
