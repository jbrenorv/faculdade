import 'package:firebase_auth/firebase_auth.dart';
import 'package:freckt_fretista/models/fretista.model.dart';
import 'package:freckt_fretista/views/completar_cadastro.dart';
import 'package:freckt_fretista/views/home_fretista.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freckt_fretista/views/loading.dart';
import 'package:freckt_fretista/views/something_went_wrong.dart';
import 'package:freckt_fretista/views/verify_email.dart';

class GetUserData extends StatefulWidget {
  GetUserData(this.path);

  /// O [path] deverá ser o [uid] do usuário autenticado e será o nome
  /// do documento deste usuário no [FirebaseFirestore].
  final String path;

  @override
  _GetUserDataState createState() => _GetUserDataState();
}

class _GetUserDataState extends State<GetUserData> {
  /// O [model] e uma [Reference] para a coleção [fretistas] no
  /// [FirebaseFirestore].
  final model = FretistaModel();

  final fretistas = FirebaseFirestore.instance.collection('fretistas');
  final user = FirebaseAuth.instance.currentUser;

  /// O [build] metodo retorna um [FutureBuilder] que buscará os dados
  /// do usuário autenticado e carregará no model. Enquanto isso é feito,
  /// será exibido um [CircularProgressIndicator]

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fretistas.doc(widget.path).get(), // future(), //
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return SomethingWentWrong(snapshot.error.toString());
        }

        if (snapshot.connectionState == ConnectionState.done) {
          final data = snapshot.data.data();

          if (data['vehicles'] != null) {
            model.loadDataFromFirestore(data: data);
            if (user.emailVerified)
              return HomeFretista();
            else
              return VerifyEmailScreen();
          } else {
            model.loadRegistrationData(data: data);
            return CompletarCadastro();
          }
        }

        return Loading();
      },
    );
  }
}
