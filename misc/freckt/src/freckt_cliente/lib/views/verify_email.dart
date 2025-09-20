import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freckt_cliente/utils/consts.dart';
import 'package:freckt_cliente/utils/route_name.dart';
import 'package:freckt_cliente/utils/templates/elevated_button_template.dart';

class VerifyEmailScreen extends StatefulWidget {
  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final auth = FirebaseAuth.instance;
  User user;
  Timer timer;

  @override
  void initState() {
    super.initState();

    user = auth.currentUser;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Icon(
              Icons.outgoing_mail,
              color: Consts.greenDark,
              size: 80,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  'Um email foi enviado para',
                  textAlign: TextAlign.center,
                ),
                Text(
                  '${user.email}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\nClique no link do email recebido para validar sua conta e começar a utilizar o aplicativo',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Text('Não recebeu?', style: TextStyle(color: Colors.grey)),
          ElevatedButtonTemplate(onPressed: () {}, buttonText: 'Reenviar')
        ],
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteName.HOME,
        (route) => false,
      );
    }
  }
}
