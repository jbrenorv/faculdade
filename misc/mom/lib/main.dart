import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/app_di.dart';
import 'pages/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppDi.resolveAsyncDependencies();

  runApp(
    MultiRepositoryProvider(
      providers: AppDi.repositories,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: false).copyWith(
          appBarTheme: const AppBarTheme(
            elevation: 0,
          ),
        ),
        home: const WelcomePage(),
      ),
    )
  );
}
