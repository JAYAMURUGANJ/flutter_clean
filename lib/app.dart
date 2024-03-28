import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/routes/routes.dart';
import 'config/theme/app_themes.dart';
import 'features/temple/presentation/bloc/itms/itms_bloc.dart';
import 'features/temple/presentation/bloc/itms/itms_event.dart';
import 'features/temple/presentation/pages/home/temple_list.dart';
import 'injection_container.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ITMSBloc>(
          create: (context) => sl()..add(GetTempleList()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        home: const TempleList(),
      ),
    );
  }
}
