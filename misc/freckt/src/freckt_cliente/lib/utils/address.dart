import 'package:flutter/widgets.dart';

class Address {
  String municipio;
  String uf;
  String bairro;
  String rua;
  String numero;
  String cep;

  Address({
    @required this.municipio,
    @required this.uf,
    @required this.bairro,
    @required this.rua,
    @required this.numero,
    @required this.cep,
  });
}
