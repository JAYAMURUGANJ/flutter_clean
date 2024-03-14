import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/temple/presentation/bloc/temple/remote/temple_list_bloc.dart';
import 'package:news_app_clean_architecture/features/temple/presentation/bloc/temple/remote/temple_list_state.dart';

import '../../../domain/entities/temple.dart';
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
    return BlocBuilder<TempleListBloc, TempleListState>(
      builder: (_, state) {
        if (state is TempleListLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is TempleListLodingError) {
          DioException? error = state.error;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.dangerous),
                Text(error!.response!.statusCode.toString())
              ],
            ),
          );
        }
        if (state is TempleListLoadingSomthingWentWrong) {
          return Center(
              child: Text(
            state.responseStatus!,
            textAlign: TextAlign.center,
          ));
        }
        if (state is TempleListLoaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return TempleListTile(
                temple: state.templeList![index],
                onArticlePressed: (article) =>
                    _onArticlePressed(context, article),
              );
            },
            itemCount: state.templeList!.length,
          );
        }
        return const SizedBox();
      },
    );
  }

  void _onArticlePressed(BuildContext context, TempleEntity article) {
    Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
  }

  void _onShowSavedArticlesViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/SavedArticles');
  }
}
