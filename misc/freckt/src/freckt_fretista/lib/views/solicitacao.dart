import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freckt_fretista/utils/consts.dart';
import 'package:freckt_fretista/utils/enums/tipo_frete.dart';
import 'package:freckt_fretista/utils/status_frete.dart';
import 'package:freckt_fretista/utils/templates/form_field_template.dart';
import 'package:freckt_fretista/views/chat.dart';

class Solicitacao extends StatefulWidget {
  final DocumentSnapshot document;
  final TipoFrete tipoFrete;

  const Solicitacao(
      {Key key, this.document, this.tipoFrete = TipoFrete.SOLICITACAO})
      : super(key: key);

  @override
  _SolicitacaoState createState() => _SolicitacaoState();
}

class _SolicitacaoState extends State<Solicitacao> {
  Map<String, dynamic> data;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    data = widget.document.data();
  }

  void setStatusFrete(int status, {String motivo = ''}) async {
    setState(() {
      _isLoading = true;
    });

    await widget.document.reference.update({
      'status': status,
      'motivo': motivo,
    });

    data['status'] = status;

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _onConcluido() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Text('Maracar como concluído'),
          content: Text(
            'Esta ação determina que o frete já foi entregue ao seu destino final.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setStatusFrete(StatusFrete.CONCLUIDO);
                Navigator.pop(context);
              },
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _onPressRecusar() async {
    final _formKey = GlobalKey<FormState>();
    String _motivoCancelamento;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Text('Recusar frete'),
          content: Form(
            key: _formKey,
            child: FormFieldTemplate(
              title: 'Informe um motivo',
              hintText: '',
              keyboardType: TextInputType.text,
              onChanged: (motivo) {
                _motivoCancelamento = motivo;
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'É necessário informar um motivo';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  setStatusFrete(
                    StatusFrete.REJEITADO,
                    motivo: _motivoCancelamento,
                  );
                  Navigator.pop(context);
                }
              },
              child: Text('Recusar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Widget formatAddress({
    @required String rua,
    @required String numero,
    @required String bairro,
    @required String municipio,
    @required String uf,
    @required String cep,
    @required bool isPartida,
  }) {
    return Container(
      child: ListTile(
        leading: isPartida
            ? Icon(Icons.radio_button_unchecked_rounded)
            : Icon(Icons.location_on_outlined),
        title: Text(isPartida ? 'Local de partida' : 'Destino'),
        subtitle: Text(
          '$rua, n° $numero - $bairro, $municipio - $uf, $cep.',
        ),
      ),
    );
  }

  Widget formatDescricao({@required String descricao}) {
    return Container(
      child: ListTile(
        leading: Icon(Icons.description),
        title: Text('Descrição da carga'),
        subtitle: Text(descricao),
      ),
    );
  }

  Widget aboutStatus() {
    //print(Theme.of(context).textTheme.title);
    switch (data['status']) {
      case StatusFrete.CONCLUIDO:
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Parabéns!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff13786C),
                  fontSize: 20.0,
                ),
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:
                        'Você concluiu este frete. Ele ainda ficará visível no seu histórico de fretes.\n\nOcorreu algum problema? Nos informe pelo ',
                  ),
                  TextSpan(
                    text: 'fale conosco.',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
        break;
      case StatusFrete.CANCELADO:
        return Container();
        break;
      case StatusFrete.EM_ANDAMENTO:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      'Entre em contato com o cliente para discutir assuntos sobre o frete',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Chat(
                            clienteId: data['clienteId'],
                            clienteName: data['clienteName'],
                            clientePhotoUrl: data['clientePhotoUrl'],
                          ),
                        ),
                      );
                    },
                    child: Text('Enviar mensagem'),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff13786C),
                    ),
                  ),
                ],
              ),
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
              decoration: BoxDecoration(
                color: Consts.greyColor2,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      'Este frete já foi concluído?',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _onConcluido();
                      //setStatusFrete(StatusFrete.CONCLUIDO);
                    },
                    child: Text('Marcar como concluído'),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff13786C),
                    ),
                  ),
                ],
              ),
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
              decoration: BoxDecoration(
                color: Consts.greyColor2,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ],
        );
        break;
      case StatusFrete.ESPERANDO_RESPOSTA:
        return Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    await _onPressRecusar();
                  },
                  child: Text('Recusar'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                ),
                SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () {
                    setStatusFrete(StatusFrete.EM_ANDAMENTO);
                  },
                  child: Text('Aceitar'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff13786C),
                  ),
                ),
              ],
            ),
            /*ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Chat(
                      clienteId: data['clienteId'],
                      clienteName: data['clienteName'],
                      clientePhotoUrl: data['clientePhotoUrl'],
                    ),
                  ),
                );
              },
              child: Text('Enviar mensagem'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xff13786C),
              ),
            ),*/
          ],
        );
        break;
      case StatusFrete.REJEITADO:
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Frete rejeitado',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontSize: 20.0,
                ),
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:
                        'Infelizmente, por algum motivo você não aceitou este frete.\n\nOcorreu algum problema? Nos informe pelo ',
                  ),
                  TextSpan(
                    text: 'fale conosco.',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
        break;
      default:
        return Container();
        break;
    }
  }

  Widget formatDay(String date) {
    return Container(
      child: ListTile(
        leading: Icon(Icons.calendar_today),
        title: Text('Data'),
        subtitle: Text(date),
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
        title: Text('Solicitação'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Container(
          child: Column(
            children: [
              formatAddress(
                rua: data['origemRua'],
                numero: data['origemNumero'],
                bairro: data['origemBairro'],
                municipio: data['origemMunicipio'],
                uf: data['origemUf'],
                cep: data['origemCep'],
                isPartida: true,
              ),
              formatAddress(
                rua: data['destinoRua'],
                numero: data['destinoNumero'],
                bairro: data['destinoBairro'],
                municipio: data['destinoMunicipio'],
                uf: data['destinoUf'],
                cep: data['destinoCep'],
                isPartida: false,
              ),
              widget.tipoFrete == TipoFrete.AGENDAMENTO
                  ? Column(
                      children: [
                        Divider(),
                        formatDay(data['date']),
                      ],
                    )
                  : Container(),
              Divider(),
              formatDescricao(descricao: data['descricao']),
              Divider(),
              _isLoading
                  ? CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xff13786C)),
                    )
                  : aboutStatus(),
            ],
          ),
        ),
      ),
    );
  }
}
