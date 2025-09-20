import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:freckt_cliente/utils/frete.dart';
import 'package:freckt_cliente/utils/fretista.dart';
import 'package:freckt_cliente/utils/templates/avatar_template.dart';
import 'package:freckt_cliente/utils/templates/elevated_button_template.dart';
import 'package:freckt_cliente/views/resumo_solicitacao.dart';

class ItemFretista {
  final Fretista fretista;
  bool selecionado;

  ItemFretista({@required this.fretista, this.selecionado = false});
}

class SelecionarFretista extends StatefulWidget {
  final Frete frete;
  final List<Fretista> fretistas;

  SelecionarFretista({@required this.frete, @required this.fretistas});

  @override
  _SelecionarFretistaState createState() => _SelecionarFretistaState(
        fretistas.map(
          (Fretista fretista) {
            return ItemFretista(fretista: fretista);
          },
        ).toList(),
      );
}

class _SelecionarFretistaState extends State<SelecionarFretista> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<ItemFretista> data;
  List<Fretista> selecionados = <Fretista>[];
  int _numSelecionados = 0;

  _SelecionarFretistaState(this.data);

  Widget _buildListFretistas() {
    return ListView(
      padding: EdgeInsets.only(bottom: 75.0),
      children: data.map((ItemFretista item) {
        return CheckboxListTile(
          contentPadding: EdgeInsets.all(10.0),
          value: item.selecionado,
          onChanged: (value) {
            if (_numSelecionados < 3) {
              _numSelecionados += value ? 1 : -1;
              if (value)
                selecionados.add(item.fretista);
              else
                selecionados.remove(item.fretista);

              setState(() {
                item.selecionado = value;
              });
            } else if (value) {
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text('Selecione até 3 fretistas.'),
                ),
              );
            } else {
              _numSelecionados--;
              selecionados.remove(item.fretista);
              setState(() {
                item.selecionado = value;
              });
            }
          },
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.fretista.name),
              Text(item.fretista.municipio),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${item.fretista.marca} ${item.fretista.cor} com capacidade para ${item.fretista.capacidade}kg',
              ),
              RatingBarIndicator(
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemSize: 20.0,
                rating: item.fretista.rating,
              ),
            ],
          ),
          secondary: AvatarTemplate(url: item.fretista.photoUrl),
          activeColor: Color(0xff13786C),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xff20B8A6),
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Selecionar fretista'),
      ),
      body: Container(child: _buildListFretistas()),
      floatingActionButton: ElevatedButtonTemplate(
        onPressed: _numSelecionados == 0
            ? null
            : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResumoSolicitacao(
                      frete: widget.frete,
                      fretistas: selecionados,
                    ),
                  ),
                );
              },
        buttonText: 'Avançar',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
