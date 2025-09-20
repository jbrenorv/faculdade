import 'package:flutter/material.dart';
import 'package:freckt_cliente/models/cliente.model.dart';
import 'package:freckt_cliente/utils/enums/response_status.dart';
import 'package:freckt_cliente/views/conta.dart';
import 'package:freckt_cliente/views/entrar.dart';
import 'package:freckt_cliente/views/privacidade.dart';
import 'package:freckt_cliente/views/seguranca.dart';
import 'package:freckt_cliente/views/sobre.dart';

import '../models/cliente.model.dart';

class Configuracoes extends StatefulWidget {
  final model = ClienteModel();

  @override
  _ConfiguracoesState createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sair?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Não'),
            ),
            TextButton(
              onPressed: () async {
                final response = await widget.model.signOutUser();

                if (response.status == ResponseStatus.SUCCESS) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Entrar(),
                    ),
                    (route) => false,
                  );
                } else {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(response.message),
                    ),
                  );
                }
              },
              child: Text('Sim'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff20B8A6),
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        //centerTitle: true,
        title: Text(
          'Configurações',
          //style: GoogleFonts.roboto(color: Colors.white),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        height: double.infinity,
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.vpn_key_rounded),
              title: Text('Conta'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Conta(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.lock_rounded),
              title: Text('Privacidade'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Privacidade(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.security_rounded),
              title: Text('Segurança'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Seguranca(),
                  ),
                );
              },
            ),
            /* ListTile(
              title: Text('Sobre'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Sobre(),
                  ),
                );
              },
            ),*/
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'Encerrar sessão',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () async {
                await _showDialog();
              },
            ),
          ],
        ),
      ),
    );
  }
}
