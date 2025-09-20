import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freckt_cliente/utils/address.dart';
import 'package:freckt_cliente/utils/enums/tipo_frete.dart';
import 'package:freckt_cliente/utils/status_frete.dart';

class Frete {
  Address origem;
  Address destino;
  TipoFrete tipoFrete;
  DateTime date;
  //TimeOfDay time;
  String descricao;

  /// usar classe [StatusFrete]
  int _status = StatusFrete.ESPERANDO_RESPOSTA;

  Frete({
    @required this.origem,
    @required this.destino,
    @required this.descricao,
    @required this.tipoFrete,
    this.date,
    //this.time,
  });

  set setStatus(int value) => _status = value;
  int get getStatus => _status;
}
