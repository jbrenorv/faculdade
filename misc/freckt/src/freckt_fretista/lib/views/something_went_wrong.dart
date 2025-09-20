import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong(this.error);

  final String error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Card(
            child: ListTile(
              title: Text(
                'Algo deu errado!\nVerifique sua conexão com a internet.',
              ),
              subtitle: Text('Error: $error'),
            ),
          ),
        ),
      ),
    );
  }
}
