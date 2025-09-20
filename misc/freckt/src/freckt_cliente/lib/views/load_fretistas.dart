import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freckt_cliente/utils/frete.dart';
import 'package:freckt_cliente/utils/fretista.dart';
import 'package:freckt_cliente/views/loading.dart';
import 'package:freckt_cliente/views/selecionar_fretista.dart';
import 'package:freckt_cliente/views/something_went_wrong.dart';

class LoadFretistas extends StatefulWidget {
  final Frete frete;

  LoadFretistas({@required this.frete});

  @override
  _LoadFretistasState createState() => _LoadFretistasState();
}

class _LoadFretistasState extends State<LoadFretistas> {
  final reference = FirebaseFirestore.instance.collection('fretistas');

  List<Fretista> fretistas;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: reference.where('completeRegistration', isEqualTo: true).get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return SomethingWentWrong(snapshot.error.toString());
        }

        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            fretistas = snapshot.data.docs.map((doc) {
              return Fretista(data: doc.data());
            }).toList();
            return SelecionarFretista(
              frete: widget.frete,
              fretistas: fretistas,
            );
          } else {
            return Flexible(
              child: Container(
                child: Center(
                  child: Text(
                    'Infelizmente, ainda não temos fretistas cadastrados.',
                  ),
                ),
              ),
            );
          }
        }
        return Loading();
      },
    );
  }
}
