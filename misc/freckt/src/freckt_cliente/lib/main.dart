import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:freckt_cliente/utils/route_name.dart';
import 'package:freckt_cliente/views/entrar.dart';
import 'package:freckt_cliente/views/get_user_data.dart';
import 'package:freckt_cliente/views/home_cliente.dart';
import 'package:freckt_cliente/views/loading.dart';
import 'package:freckt_cliente/views/something_went_wrong.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteName.ROOT,
      title: 'Freckt Cliente',
      theme: ThemeData(primaryColor: const Color(0xff13786C)),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      routes: {
        RouteName.ROOT: (context) => Root(),
        RouteName.HOME: (context) => HomeCliente(),
        RouteName.GET_USER_DATA: (context) => GetUserData(),

        /// Aqui incluir as [rotas] do app
      },
    ),
  );
}

class Root extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return SomethingWentWrong(snapshot.error.toString());
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          /// [user] será o usuário atual
          final user = FirebaseAuth.instance.currentUser;

          /// Se [user] for [null], significa que não temos um fretista
          /// autenticado no momento. Se este for o caso, chamamos a tela de
          /// [Entrar] para que um novo usuário faça login ou cadastre-se.
          /// Se ao invés disso tivermos um fretista, chamamos [GetUserData]
          /// para acessar o [FirebaseFirestore] e carregar o [model] com
          /// as informações dele.
          return (user != null ? GetUserData() : Entrar());
        }

        /// [warning]: a tela de [Splash] não está pronta.
        // Otherwise, show something whilst waiting for initialization to complete.
        return Loading(); //Loading();
      },
    );
  }
}
