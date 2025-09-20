import 'package:flutter/widgets.dart';
import 'package:freckt_fretista/views/loading.dart';
import 'package:freckt_fretista/views/verif_aprovada.dart';
import 'package:freckt_fretista/views/verif_negada.dart';

class Verificacao extends StatefulWidget {
  @override
  _VerificacaoState createState() => _VerificacaoState();
}

class _VerificacaoState extends State<Verificacao> {
  Future<bool> verificacao = Future.delayed(
    Duration(seconds: 3),
    () => true,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: verificacao,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Algo deu errado :('),
          );
        }

        if (snapshot.hasData) {
          if (snapshot.data) {
            return VerifAprovada();
          } else {
            return VerifNegada();
          }
        }

        return Loading();
      },
    );
  }
}
