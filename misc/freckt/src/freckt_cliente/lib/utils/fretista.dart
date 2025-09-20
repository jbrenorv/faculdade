import 'package:flutter/widgets.dart';

class Fretista {
  final Map<String, dynamic> data;

  String id = '';
  String name = '';
  String email = '';
  String phone = '';
  String photoUrl = '';
  String municipio = '';
  String marca = '';
  String cor = '';
  String tipo = '';
  String capacidade = '';

  double rating = 0.0;

  Fretista({@required this.data}) {
    final aux = data['vehicles'][0];

    id = data['id'];
    name = data['name'];
    email = data['email'];
    phone = data['phone'];
    photoUrl = data['photoUrl'];
    marca = aux['marca'];
    cor = aux['cor'];
    tipo = aux['tipo'];
    capacidade = aux['capacidade'];
    municipio = 'Fortaleza/CE';
    rating = 3.5;
  }
}
