import 'package:flutter/widgets.dart';
import 'package:freckt_fretista/utils/templates/button_template.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  static const String _title = 'Verificação';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          _title,
          style: TextStyle(color: Colors.black),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ButtonTemplate(
        onPressed: () {},
        buttonText: 'Verificar',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text.rich(
              TextSpan(
                text:
                    'O Freckt enviará um SMS para verificar seu número de telefone. ',
                children: [
                  TextSpan(
                    text: 'Número errado?',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            FlatButton(
              onPressed: () {},
              child: ListTile(
                leading: Icon(Icons.message_outlined),
                title: Text('Reenviar SMS'),
              ),
            ),
            Divider(),
            FlatButton(
              onPressed: () {},
              child: ListTile(
                leading: Icon(Icons.phone),
                title: Text('Me ligue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
