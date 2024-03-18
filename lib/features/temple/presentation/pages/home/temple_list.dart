import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/temple.dart';
import '../../bloc/temple/remote/temple_list_bloc.dart';
import '../../bloc/temple/remote/temple_list_state.dart';
import '../../widgets/temple_tile.dart';

class TempleList extends StatelessWidget {
  const TempleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody(),
    );
  }

  _buildAppbar(BuildContext context) {
    return AppBar(
      title: const Text(
        'HR&CE Temples',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  _buildBody() {
    return BlocConsumer<TempleListBloc, TempleListState>(
      listener: (context, state) {
        if (state is TempleListLodingError) {
          Navigator.pushNamed(context, '/DioException',
              arguments: state.error!);
        }
        if (state is TempleListLoadingSomthingWentWrong) {
          Navigator.pushNamed(context, '/SomthingWentWrong',
              arguments: state.responseStatus!);

          // Center(
          //     child: Text(
          //   state.responseStatus!,
          //   textAlign: TextAlign.center,
          // ));
        }
      },
      builder: (context, state) {
        if (state is TempleListLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }

        if (state is TempleListLoaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return TempleListTile(
                temple: state.templeList![index],
                onTemplePressed: (article) =>
                    _onTemplePressed(context, article),
              );
            },
            itemCount: state.templeList!.length,
          );
        }
        return const SizedBox();
      },
    );
  }

  void _onTemplePressed(BuildContext context, TempleEntity article) {
    Navigator.pushNamed(context, '/TempleDetails', arguments: article);
  }
}
