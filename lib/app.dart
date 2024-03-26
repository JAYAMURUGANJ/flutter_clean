import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/routes/routes.dart';
import 'config/theme/app_themes.dart';
import 'features/temple/presentation/bloc/temple/remote/temple_list_bloc.dart';
import 'features/temple/presentation/bloc/temple/remote/temple_list_event.dart';
import 'features/temple/presentation/pages/home/temple_list.dart';
import 'injection_container.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // TempleListEvent event = GetTempleList("");
  TempleListEvent event = GetTempleList(
      "c3nrHhotvFSdP1K1M56rMr+Le69TainETEdmnSI+5H37bNUtPDI/2roif7aQjr/yKDoENP/XvOtBMp4lrda1tS7innVBW/0nyxBXKDnoT62vyhluE6Bmkp/ymcfQly7Dz/yHKlNk+AyuScmuSWSBeI8z9yX3mV7gRaMcap6HrjtJMNmRo+UATpUop1uEIe/qs4YvZ3QNOTAWOFVbsTkMzMR/\n94p2xvqUMdw/koMSx6M0YQvqSUpBghZ8EWyJ+HJ9squ7eSZ4IOCCKW19cyE3g/w0jpYcS3ET6rQUZIFERtrmuhMd+i7Qw8ulkZeY4PwsbqFDDdMhWCtgDO8R+qi9n/QxerzyP6kBVSBvxDL3LSdvjiD0uS4qMFNFxJidtyyZZH8hQnl1sm5sneD+exUVQElE/6TUiRGF78LGwJmhTHcvT3V5\npMd+J7KisMScTJ5P0ZvmG81hOkldYGYC9oPaJdV4Gk0Y/umPZm/XIonCnvggvCAvD5bSpwFN3S33cKJFdUpKSy7XzCF5KKZjrVTMTITOgLb9JjQ/ZpeolEF8eN1AohZyQGvfDdZyHzeosdblir98OeZZny1f9Kizfelcgk8783VkD57PZaxqo3FQQYp1ll6WMv976Tp84SJEPrKCP9URpP7S\nl3ua1ETG6BHdnwTC7TxIkYzwsR3TaMNMfO4MkfDLAP+YVtJuhu5WRWQiCig1tZm77wSK2nZkFu/R6B422J0iOzggTK3y3nQu5MDxAz3NVpkr77aCOH7T4Y6eFjRxhiwaXNT3PzqHa4+qsQ==");
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
            BlocProvider<TempleListBloc>(
          create: (context) => sl()..add(event),
    
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
