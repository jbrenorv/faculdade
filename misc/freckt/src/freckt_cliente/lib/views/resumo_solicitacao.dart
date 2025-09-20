import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freckt_cliente/models/cliente.model.dart';
import 'package:freckt_cliente/utils/address.dart';
import 'package:freckt_cliente/utils/enums/tipo_frete.dart';
import 'package:freckt_cliente/utils/frete.dart';
import 'package:freckt_cliente/utils/fretista.dart';
import 'package:freckt_cliente/utils/route_name.dart';
import 'package:freckt_cliente/utils/templates/avatar_template.dart';
import 'package:freckt_cliente/utils/templates/elevated_button_template.dart';

class ResumoSolicitacao extends StatefulWidget {
  final Frete frete;
  final List<Fretista> fretistas;

  ResumoSolicitacao({
    @required this.frete,
    @required this.fretistas,
  });

  @override
  _ResumoSolicitacaoState createState() => _ResumoSolicitacaoState();
}

class _ResumoSolicitacaoState extends State<ResumoSolicitacao> {
  final model = ClienteModel();
  bool _isLoading = false;

  Future<void> _showDialog() async {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Solicitação enviada'),
          content: Text('Agora é só esperar uma resposta do fretista'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.popUntil(
                  //context, (route) => false) //pushAndRemoveUntil(
                  context,
                  //MaterialPageRoute(
                  //  builder: (context) => Fretes(),
                  //),
                  //ModalRoute.withName('/'),
                  (route) {
                    String routeName = route.settings.name;
                    return (routeName == RouteName.ROOT ||
                        routeName == RouteName.GET_USER_DATA ||
                        routeName == RouteName.HOME);
                  },
                );
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  String _twoDigits(int n) => (n < 10 ? '0$n' : '$n');

  String dateToString(DateTime date) {
    int y = date.year;
    String m = _twoDigits(date.month);
    String d = _twoDigits(date.day);

    return '$d-$m-$y';
  }

  void enviar() async {
    setState(() {
      _isLoading = true;
    });

    int index = 0;
    final date = widget.frete.tipoFrete == TipoFrete.SOLICITACAO
        ? 'Sem data'
        : dateToString(widget.frete.date);
    final collection = widget.frete.tipoFrete == TipoFrete.SOLICITACAO
        ? 'solicitacoes'
        : 'agendamentos';
    final aux = DateTime.now().millisecondsSinceEpoch.toString();
    final timestamp = FieldValue.serverTimestamp();
    final docs = <String>[
      '${model.getUserId}-$aux-0',
      '${model.getUserId}-$aux-1',
      '${model.getUserId}-$aux-2',
    ];

    widget.fretistas.forEach(
      (fretista) async {
        await FirebaseFirestore.instance
            .collection(collection)
            .doc(docs[index++])
            .set(
          {
            'visivelFretista': true,
            'visivelCliente': true,
            'fretistaPhone': fretista.phone,
            'clientePhone': model.getUserPhone,
            'date': date,
            'fretistaId': fretista.id,
            'fretistaPhotoUrl': fretista.photoUrl,
            'fretistaName': fretista.name,
            'preco': '150,00',
            'status': widget.frete.getStatus,
            'origemMunicipio': widget.frete.origem.municipio,
            'origemUf': widget.frete.origem.uf,
            'origemBairro': widget.frete.origem.bairro,
            'origemRua': widget.frete.origem.rua,
            'origemNumero': widget.frete.origem.numero,
            'origemCep': widget.frete.origem.cep,
            'destinoMunicipio': widget.frete.destino.municipio,
            'destinoUf': widget.frete.destino.uf,
            'destinoBairro': widget.frete.destino.bairro,
            'destinoRua': widget.frete.destino.rua,
            'destinoNumero': widget.frete.destino.numero,
            'destinoCep': widget.frete.destino.cep,
            'descricao': widget.frete.descricao,
            'clienteName': model.getUserName,
            'clientePhotoUrl': model.getPhotoUrl,
            'clienteId': model.getUserId,
            'timestamp': timestamp,
          },
        );
      },
    );

    await _showDialog();
  }

  Widget formatFretista(Fretista fretista) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: ListTile(
        leading: AvatarTemplate(url: fretista.photoUrl),
        title: Text(fretista.name),
        subtitle: Text(
          '${fretista.marca} ${fretista.cor} com capacidade para ${fretista.capacidade}kg',
        ),
      ),
    );
  }

  Widget formatAddress(Address address, bool partida) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: ListTile(
        leading: partida
            ? Icon(Icons.radio_button_unchecked_rounded)
            : Icon(Icons.location_on_outlined),
        title: Text(partida ? 'Local de partida' : 'Destino'),
        subtitle: Text(
          '${address.rua}, n° ${address.numero} - ${address.bairro}, ${address.municipio} - ${address.uf}, ${address.cep}.',
        ),
      ),
    );
  }

  Widget formatDescricao() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: ListTile(
        leading: Icon(Icons.description),
        title: Text('Descrição da carga'),
        subtitle: Text(widget.frete.descricao),
      ),
    );
  }

  Widget formatDay() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: ListTile(
        leading: Icon(Icons.calendar_today),
        title: Text('Data'),
        subtitle: Text(dateToString(widget.frete.date)),
      ),
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
        title: Text('Sua solicitação'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 75.0),
        child: Container(
          child: Column(
            children: [
              Column(
                children: widget.fretistas.map((Fretista fretista) {
                  return formatFretista(fretista);
                }).toList(),
              ),
              Divider(),
              formatAddress(widget.frete.origem, true),
              formatAddress(widget.frete.destino, false),
              Divider(),
              widget.frete.tipoFrete == TipoFrete.AGENDAMENTO
                  ? Column(
                      children: [
                        formatDay(),
                        Divider(),
                      ],
                    )
                  : Container(),
              formatDescricao(),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButtonTemplate(
        onPressed: _isLoading ? null : enviar,
        buttonText: 'Enviar',
        color: Color(0xff13786C),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
