import 'package:flutter/material.dart';
import 'package:freckt_fretista/models/fretista.model.dart';
import 'package:freckt_fretista/utils/consts.dart';
import 'package:freckt_fretista/utils/enums/response_status.dart';
import 'package:freckt_fretista/views/conta.dart';
import 'package:freckt_fretista/views/entrar.dart';
import 'package:freckt_fretista/views/privacidade.dart';
import 'package:freckt_fretista/views/seguranca.dart';
import 'package:freckt_fretista/views/sobre.dart';
import 'package:freckt_fretista/views/veiculos.dart';

class Configuracoes extends StatefulWidget {
  final model = FretistaModel();

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
                final response = await widget.model.signOutFretista();

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
        backgroundColor: Consts.greenAppBar,
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
              leading: Icon(Icons.directions_car_rounded),
              title: Text('Veículos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Veiculos(),
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
            //ListTile(
            //  leading: Icon(Icons.text_snippet_rounded),
            //  title: Text('Sobre'),
            //  onTap: () {
            //    Navigator.push(
            //      context,
            //      MaterialPageRoute(
            //        builder: (context) => Sobre(),
            //      ),
            //    );
            //  },
            //),
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
