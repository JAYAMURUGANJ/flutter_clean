import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/config/routes/routes.dart';
import 'package:news_app_clean_architecture/features/temple/presentation/bloc/temple/remote/temple_list_event.dart';
import 'package:news_app_clean_architecture/features/temple/presentation/pages/home/temple_list.dart';

import 'config/theme/app_themes.dart';
import 'features/temple/presentation/bloc/temple/remote/temple_list_bloc.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TempleListBloc>(
      create: (context) => sl()..add(GetTempleList("")),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme(),
          onGenerateRoute: AppRoutes.onGenerateRoutes,
          home: const TempleList()),
    );
  }
}
