import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/color_schemes.g.dart';
import '../bloc/theme/theme_bloc.dart';

class ThemeList extends StatelessWidget {
  const ThemeList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (BuildContext context, ThemeState themeState) {
        return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: lightColorScheme.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisSpacing: 12.0,
                crossAxisSpacing: 20,
                mainAxisExtent: 51.0,
                maxCrossAxisExtent: 50),
            itemBuilder: (_, int index) {
              return GestureDetector(
                  onTap: () {
                    BlocProvider.of<ThemeBloc>(context)
                        .add(LightModeEvent(index: index));
                  },
                  child: CircleAvatar(
                    radius: 29,
                    backgroundColor: themeState is LightModeState
                        ? index == themeState.index
                            ? lightColorScheme[index].primary
                            : Colors.transparent
                        : Colors.transparent,
                    child: CircleAvatar(
                      radius: 23,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: lightColorScheme[index].primary,
                      ),
                    ),
                  ));
            });
      },
    );
  }
}
