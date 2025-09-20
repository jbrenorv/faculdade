import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:freckt_cliente/models/cliente.model.dart';
import 'package:freckt_cliente/views/agendamentos.dart';
import 'package:freckt_cliente/views/chats.dart';
import 'package:freckt_cliente/views/configuracoes.dart';
//import 'package:freckt_cliente/views/agendamentos.dart';
import 'package:freckt_cliente/views/fale_conosco.dart';
import 'package:freckt_cliente/views/sobre.dart';
import 'package:freckt_cliente/views/solicitacoes.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCliente extends StatefulWidget {
  @override
  _HomeClienteState createState() => _HomeClienteState();
}

/// Uma [home] não oficial apenas para testar o cadastro e o login
class _HomeClienteState extends State<HomeCliente> {
  final model = ClienteModel();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            'freckt',
            style: GoogleFonts.comfortaa(
              fontSize: 24.0,
              color: Colors.black,
            ),
          ),

          //Text(
          //  'Freckt', //Olá ${model.name.split(' ')[0]}',
          //  style: TextStyle(color: Colors.black),
          //),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(model.photoUrl),
                backgroundColor: Colors.black12,
              ),
            ),
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return <PopupMenuItem>[
                  PopupMenuItem(
                    child: ListTile(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Configuracoes(),
                          ),
                        );
                      },
                      leading: Icon(Icons.settings),
                      title: Text('Configurações'),
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Ajuda(),
                          ),
                        );
                      },
                      leading: Icon(Icons.help),
                      title: Text('Ajuda'),
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FaleConosco(),
                          ),
                        );
                      },
                      leading: Icon(Icons.message_rounded),
                      title: Text('Fale conosco'),
                    ),
                  ),
                ];
              },
            ),
          ],
          bottom: TabBar(
            indicatorColor: Color(0xff13786C),
            labelColor: Colors.black,
            tabs: <Tab>[
              Tab(text: 'Solicitações'),
              Tab(text: 'Agendamentos'),
              Tab(text: 'Conversas'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Fretes(),
            Agendamentos(),
            Chats(),
          ],
        ),
      ),
    );
  }
}
