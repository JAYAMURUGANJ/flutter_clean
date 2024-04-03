import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/bloc/temple_details/temple_info_bloc.dart';

import '../../../../config/common/widgets/something_went_wrong.dart';
import '../../domain/entities/temple_info.dart';

class TempleInfoWidget extends StatelessWidget {
  const TempleInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TempleInfoBloc, TempleInfoState>(
      listener: (context, state) {
        if (state is TempleInfoLodingError) {
          Navigator.pushNamed(context, '/DioException',
              arguments: state.error!);
        }
      },
      builder: (context, state) {
        if (state is TempleInfoLoading) {
          return const CupertinoActivityIndicator();
        }
        if (state is TempleInfoLoadingSomthingWentWrong) {
          String error = state.responseStatus!;
          return somthingWentWrong(context, error);
        }
        if (state is TempleInfoLoaded) {
          final TempleInfoEntity? templeInfo = state.templeInfo![0];
          return Text(
            templeInfo!.description ?? "-",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          );
        }
        return const Text(" No data");
      },
    );
  }
}
