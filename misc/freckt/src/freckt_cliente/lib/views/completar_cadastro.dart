import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freckt_cliente/utils/templates/elevated_button_template.dart';
import 'package:freckt_cliente/views/entrar.dart';

import 'cadastro_perfil.dart';

class CompletarCadastro extends StatelessWidget {
  CompletarCadastro({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: Icon(Icons.app_registration),
                  title: Text('Cadastro incompleto'),
                  subtitle: Text('Finalizar cadastro agora?'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: const Text('NÃO'),
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Entrar(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      child: const Text('SIM'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CadastroPerfil(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
