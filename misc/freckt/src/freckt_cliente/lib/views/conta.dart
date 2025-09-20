import 'package:freckt_cliente/models/cliente.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Conta extends StatefulWidget {
  @override
  _ContaState createState() => _ContaState();
}

class _ContaState extends State<Conta> {
  final model = ClienteModel();

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
        title: Text('Conta'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.only(top: 10.0, bottom: 50.0),
              alignment: Alignment.center,
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(model.getPhotoUrl),
                    backgroundColor: Colors.black12,
                    radius: 100.0,
                  ),
                  LimitedBox(
                    child: CircleAvatar(
                      backgroundColor: Color(0xff13786C),
                      radius: 30.0,
                      child: IconButton(
                        splashRadius: 10.0,
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        onPressed: () {}, //showBottomSheet,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle_rounded),
              title: Text('Nome'),
              subtitle: Text(model.getUserName),
            ),
            ListTile(
              leading: Icon(Icons.phone_rounded),
              title: Text('Telefone'),
              subtitle: Text(model.getUserPhone),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('E-mail'),
              subtitle: Text(model.getUserEmail),
            ),
          ],
        ),
      ),
    );
  }
}
