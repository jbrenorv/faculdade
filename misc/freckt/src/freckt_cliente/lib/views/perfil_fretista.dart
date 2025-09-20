/*import 'package:flutter/material.dart';
import 'package:freckt_cliente/views/chat.dart';

class PerfilFretista extends StatelessWidget {
  final Map<String, dynamic> data;

  PerfilFretista(this.data);

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
        title: Text(data['name']),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Enviar mensagem'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Chat(
                  data: data,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
*/
