import 'package:flutter/material.dart';
import 'package:freckt_cliente/utils/address.dart';
import 'package:freckt_cliente/utils/enums/tipo_frete.dart';
import 'package:freckt_cliente/utils/frete.dart';
import 'package:freckt_cliente/utils/templates/elevated_button_template.dart';
import 'package:freckt_cliente/utils/templates/form_field_template.dart';
import 'package:freckt_cliente/views/load_fretistas.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class SolicitarFrete extends StatefulWidget {
  final TipoFrete tipoFrete;

  const SolicitarFrete({
    Key key,
    this.tipoFrete = TipoFrete.SOLICITACAO,
  }) : super(key: key);

  @override
  _SolicitarFreteState createState() => _SolicitarFreteState();
}

class _SolicitarFreteState extends State<SolicitarFrete> {
  final _formKey = GlobalKey<FormState>();
  final format = DateFormat("dd/MM/yyyy");
  final formattime = DateFormat("HH:mm");

  DateTime date;
  //TimeOfDay time;
  String origemMunicipio;
  String origemUf;
  String origemBairro;
  String origemRua;
  String origemNumero;
  String origemCep;
  String destinoMunicipio;
  String destinoUf;
  String destinoBairro;
  String destinoRua;
  String destinoNumero;
  String destinoCep;
  String descricao;

  void makeFrete() {
    if (_formKey.currentState.validate()) {
      Frete frete = new Frete(
        tipoFrete: widget.tipoFrete,
        origem: new Address(
          municipio: origemMunicipio,
          uf: origemUf,
          bairro: origemBairro,
          rua: origemRua,
          numero: origemNumero,
          cep: origemCep,
        ),
        destino: new Address(
          municipio: destinoMunicipio,
          uf: destinoUf,
          bairro: destinoBairro,
          rua: destinoRua,
          numero: destinoNumero,
          cep: destinoCep,
        ),
        descricao: descricao,
        date: date,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoadFretistas(frete: frete),
        ),
      );
    }
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
        title: Text('Solicitando frete'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FormFieldTemplate(
                    title: 'Descrição da Carga',
                    hintText:
                        'Descreva a carga para que o fretista saiba o que irá transportar',
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Informe a carga';
                      }
                      return null;
                    },
                    maxLines: 10,
                    onChanged: (value) => descricao = value,
                  ),
                  widget.tipoFrete == TipoFrete.AGENDAMENTO
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0, top: 20.0, bottom: 10.0),
                              child: Text(
                                'Data',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: DateTimeField(
                                format: format,
                                onShowPicker: (context, currentValue) async {
                                  return date = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate: DateTime(2100),
                                    builder:
                                        (BuildContext context, Widget child) {
                                      return Theme(
                                        data: ThemeData.light().copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: Color(0xff13786C),
                                          ),
                                        ),
                                        child: child,
                                      );
                                    },
                                  );
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.calendar_today),
                                  hintText: 'Hoje',
                                ),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Informe a data';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 10.0, top: 20.0, bottom: 10.0),
                    child: Text(
                      'Local de partida',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: FormFieldTemplate(
                          title: 'Município',
                          hintText: 'Fortaleza',
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe o município de partida';
                            }
                            return null;
                          },
                          onChanged: (value) => origemMunicipio = value,
                        ),
                      ),
                      Expanded(
                        child: FormFieldTemplate(
                          title: 'UF',
                          hintText: 'CE',
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe o UF';
                            }
                            return null;
                          },
                          onChanged: (value) => origemUf = value,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: FormFieldTemplate(
                          title: 'Bairro',
                          hintText: 'Parangaba',
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe o bairro de partida';
                            }
                            return null;
                          },
                          onChanged: (value) => origemBairro = value,
                        ),
                      ),
                      Expanded(
                        child: FormFieldTemplate(
                          title: 'CEP',
                          hintText: '99999-999',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe o CEP';
                            }
                            return null;
                          },
                          onChanged: (value) => origemCep = value,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: FormFieldTemplate(
                          title: 'Rua',
                          hintText: 'Av. João Pessoa',
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe a rua de partida';
                            }
                            return null;
                          },
                          onChanged: (value) => origemRua = value,
                        ),
                      ),
                      Expanded(
                        child: FormFieldTemplate(
                          title: 'Número',
                          hintText: '123',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe o número';
                            }
                            return null;
                          },
                          onChanged: (value) => origemNumero = value,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 10.0, top: 20.0, bottom: 10.0),
                    child: Text(
                      'Destino final',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: FormFieldTemplate(
                          title: 'Município',
                          hintText: 'Fortaleza',
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe o município de destino';
                            }
                            return null;
                          },
                          onChanged: (value) => destinoMunicipio = value,
                        ),
                      ),
                      Expanded(
                        child: FormFieldTemplate(
                          title: 'UF',
                          hintText: 'CE',
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe o UF';
                            }
                            return null;
                          },
                          onChanged: (value) => destinoUf = value,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: FormFieldTemplate(
                          title: 'Bairro',
                          hintText: 'Benfica',
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe o bairro de destino';
                            }
                            return null;
                          },
                          onChanged: (value) => destinoBairro = value,
                        ),
                      ),
                      Expanded(
                        child: FormFieldTemplate(
                          title: 'CEP',
                          hintText: '88888-888',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe o CEP';
                            }
                            return null;
                          },
                          onChanged: (value) => destinoCep = value,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: FormFieldTemplate(
                          title: 'Rua',
                          hintText: 'Av. 13 de maio',
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe a rua de destino';
                            }
                            return null;
                          },
                          onChanged: (value) => destinoRua = value,
                        ),
                      ),
                      Expanded(
                        child: FormFieldTemplate(
                          title: 'Número',
                          hintText: '123',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe o número';
                            }
                            return null;
                          },
                          onChanged: (value) => destinoNumero = value,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButtonTemplate(
                onPressed: makeFrete,
                buttonText: 'Selecionar fretista',
                color: Color(0xff13786C),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
