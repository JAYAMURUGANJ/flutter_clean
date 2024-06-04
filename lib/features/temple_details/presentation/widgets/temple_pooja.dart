import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/temple_pooja.dart';
import '../bloc/temple_pooja/temple_pooja_bloc.dart';
import '/config/common/widgets/something_went_wrong.dart';
import '/config/constants.dart';

class TemplePooja extends StatelessWidget {
  const TemplePooja({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TemplePoojaBloc, TemplePoojaState>(
      listener: (context, state) {
        if (state is TemplePoojaLoadingError) {
          Navigator.pushNamed(context, '/DioException',
              arguments: state.error!);
        }
        if (state is TemplePoojaLoadingSomthingWentWrong) {
          Navigator.pushNamed(context, '/SomthingWentWrong',
              arguments: state.responseStatus!);
        }
      },
      builder: (context, state) {
        if (state is TemplePoojaLoading) {
          return const CupertinoActivityIndicator();
        }
        if (state is TemplePoojaLoadingSomthingWentWrong) {
          String error = state.responseStatus!;
          return somthingWentWrong(context, error);
        }
        if (state is TemplePoojaLoaded) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.templePooja!.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final TemplePoojaEntity? templePooja =
                    state.templePooja![index];
                return _poojaTimeCard(templePooja, context);
              },
            ),
          );
        }
        return const Center(child: Text(" No data Available"));
      },
    );
  }

  _poojaTimeCard(TemplePoojaEntity? templePooja, BuildContext context) {
    return Padding(
      padding: defaultPadding,
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                templePooja!.poojaDesc ?? "-",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              ),
              Text(
                "\u{1F553} ${templePooja.poojaTime}",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              if (templePooja.alangaram != null &&
                  templePooja.alangaram!.isNotEmpty)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  child: Text(templePooja.alangaram ?? "-",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w500)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
