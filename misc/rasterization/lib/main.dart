import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_size/window_size.dart' as window_size;

import 'src/bloc/home_bloc.dart';
import 'src/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  window_size.setWindowMinSize(const Size(960, 540));
  window_size.setWindowTitle('Rasterização');

  runApp(const CGRastApp());
}

class CGRastApp extends StatelessWidget {
  const CGRastApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CG Rast',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.amber,
        fontFamily: 'Roboto',
      ),
      home: BlocProvider<HomeBloc>(
        create: (_) => HomeBloc(),
        child: const HomePage(),
      ),
    );
  }
}
