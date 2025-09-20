import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:freckt_cliente/models/cliente.model.dart';
import 'package:freckt_cliente/utils/consts.dart';
import 'package:freckt_cliente/utils/status_frete.dart';
import 'package:freckt_cliente/utils/templates/avatar_template.dart';
import 'package:freckt_cliente/views/chat.dart';
import 'package:freckt_cliente/views/loading.dart';
import 'package:freckt_cliente/views/solicitar_frete.dart';
import 'package:freckt_cliente/views/something_went_wrong.dart';
import 'package:url_launcher/url_launcher.dart';

class Fretes extends StatefulWidget {
  @override
  _FretesState createState() => _FretesState();
}

class _FretesState extends State<Fretes> {
  final model = ClienteModel();
  final ScrollController listScrollController = ScrollController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //bool _isLoading = false;
  int _isLoadingIndex = -1;

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
      //padding: EdgeInsets.all(20.0),
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

  Future<void> _showDialog(Map<String, dynamic> data) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Text('Detalhes do frete', textAlign: TextAlign.center),
          content: SingleChildScrollView(
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
                  Divider(),
                  formatDescricao(descricao: data['descricao']),
                  Divider(),
                  data['status'] == StatusFrete.REJEITADO
                      ? Text(
                          'Segundo o fretista, o motivo de não ter aceitado sua solicitação foi:\n\n"${data['motivo']}"',
                        )
                      : Container(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Ok'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget noRequests() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Bem-vindo ao Freckt.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              TextSpan(
                  text:
                      '\n\nSuas solicitações aparecerão aqui. Quer solicitar um frete? Use o botão '),
              TextSpan(
                text: '+',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: '\nPara mais detalhes sobre este app, acesse a ',
              ),
              TextSpan(
                text: 'ajuda.',
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  String _twoDigits(int n) => (n < 10 ? '0$n' : '$n');

  bool _isToday({
    @required int day,
    @required int month,
    @required int year,
  }) {
    final today = DateTime.now();

    return (day == today.day && month == today.month && year == today.year);
  }

  String formatDateTime(DateTime dateTime) {
    int y = dateTime.year;
    int m = dateTime.month;
    int d = dateTime.day;
    String h = _twoDigits(dateTime.hour);
    String min = _twoDigits(dateTime.minute);

    String date = _isToday(day: d, month: m, year: y)
        ? 'hoje'
        : 'em ${_twoDigits(d)}-${_twoDigits(m)}-$y';

    return 'Enviado $date às $h:$min';
  }

  Text statusFrete(int status) {
    Color textColor = Colors.black;
    String text = 'Situação do frete';

    switch (status) {
      case StatusFrete.REJEITADO:
        textColor = Colors.red;
        text = 'Frete rejeitado';
        break;
      case StatusFrete.CANCELADO:
        textColor = Colors.red;
        text = 'Frete cancelado';
        break;
      case StatusFrete.ESPERANDO_RESPOSTA:
        textColor = Colors.orange;
        text = 'Esperando resposta do fretista';
        break;
      case StatusFrete.EM_ANDAMENTO:
        textColor = Colors.green;
        text = 'Frete em andamento';
        break;
      case StatusFrete.CONCLUIDO:
        textColor = Colors.green;
        text = 'Frete concluído';
        break;
      default:
        break;
    }

    return Text(text, style: TextStyle(color: textColor));
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text('Ação indisponível')),
      );
    }
  }

  void setStatusFrete({
    @required String campo,
    @required dynamic value,
    @required DocumentReference docRef,
    @required int index,
  }) async {
    setState(() {
      _isLoadingIndex = index;
      //_isLoading = true;
    });

    await docRef.update({campo: value});

    setState(() {
      _isLoadingIndex = -1;
      //_isLoading = false;
    });
  }

  Future<void> _onSetStateFrete(DocumentReference docRef, int index,
      {int newStatus = -1}) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Text(newStatus == StatusFrete.CANCELADO
              ? 'Cancelar esta solicitação?'
              : 'Apagar esta solicitação?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Não'),
            ),
            TextButton(
              onPressed: () async {
                newStatus == -1
                    ? setStatusFrete(
                        campo: 'visivelCliente',
                        value: false,
                        docRef: docRef,
                        index: index,
                      )
                    : setStatusFrete(
                        campo: 'status',
                        value: newStatus,
                        docRef: docRef,
                        index: index,
                      );
                Navigator.pop(context);
              },
              child: Text('Sim'),
            ),
          ],
        );
      },
    );
  }

  Widget bottomItem(Map<String, dynamic> data) {
    int status = data['status'];

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          (status == StatusFrete.CANCELADO || status == StatusFrete.REJEITADO)
              ? Container()
              : Row(
                  children: [
                    IconButton(
                      color: Color(0xff13786C),
                      icon: Icon(Icons.call_rounded),
                      onPressed: () async {
                        await _makePhoneCall('tel:${data['fretistaPhone']}');
                      },
                    ),
                    IconButton(
                      color: Color(0xff13786C),
                      icon: Icon(Icons.chat_rounded),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Chat(
                              fretistaId: data['fretistaId'],
                              fretistaName: data['fretistaName'],
                              fretistaPhotoUrl: data['fretistaPhotoUrl'],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget itemFrete(DocumentSnapshot doc, int index) {
    Map<String, dynamic> data = doc.data();
    Timestamp timestamp = data['timestamp'];
    String dateTime = formatDateTime(timestamp.toDate());

    return Container(
      child: FlatButton(
        child: Column(
          children: [
            Row(
              children: <Widget>[
                AvatarTemplate(url: data['fretistaPhotoUrl']),
                Flexible(
                  flex: 2,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(data['fretistaName']),
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                        ),
                        Container(
                          child: Text(dateTime),
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                        ),
                        Container(
                          child: statusFrete(data['status']),
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(left: 20.0),
                  ),
                ),
                _isLoadingIndex == index
                    ? CircularProgressIndicator(
                        strokeWidth: 1.0,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Consts.greenDark),
                      )
                    : (data['status'] == StatusFrete.EM_ANDAMENTO ||
                            data['status'] == StatusFrete.ESPERANDO_RESPOSTA)
                        ? IconButton(
                            icon: Icon(Icons.cancel_rounded),
                            onPressed: () async {
                              await _onSetStateFrete(
                                doc.reference,
                                index,
                                newStatus: StatusFrete.CANCELADO,
                              );
                            },
                            color: Colors.red,
                          )
                        : IconButton(
                            icon: Icon(Icons.delete_rounded),
                            onPressed: () async {
                              await _onSetStateFrete(
                                doc.reference,
                                index,
                              );
                            },
                            color: Colors.red,
                          ),
              ],
            ),
            bottomItem(data),
          ],
        ),
        onPressed: () async {
          await _showDialog(data);
        },
        padding: EdgeInsets.all(10.0),
      ),
      decoration: BoxDecoration(
        color: Consts.greyColor2,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      margin: EdgeInsets.all(5.0),
    );
  }

  Widget loadFretes() {
    final solicitacoes = FirebaseFirestore.instance.collection('solicitacoes');

    return StreamBuilder(
      stream: solicitacoes
          .where('clienteId', isEqualTo: model.getUserId)
          .where('visivelCliente', isEqualTo: true)
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return SomethingWentWrong(snapshot.error.toString());
        }

        if (!snapshot.hasData) {
          return Loading();
        } else {
          if (snapshot.data.docs.isEmpty) {
            return noRequests();
          }
          return ListView.builder(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 50.0),
            itemBuilder: (context, index) =>
                itemFrete(snapshot.data.docs[index], index),
            itemCount: snapshot.data.docs.length,
            controller: listScrollController,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: loadFretes(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SolicitarFrete(),
            ),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Nova solicitação',
        backgroundColor: Color(0xff13786C),
      ),
    );
  }
}
