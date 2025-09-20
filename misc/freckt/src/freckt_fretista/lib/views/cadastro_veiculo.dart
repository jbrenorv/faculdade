import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freckt_fretista/controllers/cadastro_veiculo.controller.dart';
import 'package:freckt_fretista/utils/templates/elevated_button_template.dart';
import 'package:freckt_fretista/utils/templates/form_field_template.dart';
import 'package:freckt_fretista/utils/templates/scaffold_template.dart';
import 'package:freckt_fretista/views/cadastro_perfil.dart';

class CadastroVeiculo extends StatefulWidget {
  @override
  _CadastroVeiculoState createState() => _CadastroVeiculoState();
}

class _CadastroVeiculoState extends State<CadastroVeiculo> {
  static const String _title = 'Veículo';
  static const String _buttonText = 'Próximo';

  /// Uma [Key] para gerenciar o estado do [Form]
  final _formKey = GlobalKey<FormState>();

  // O controller servirá como uma ponte entre esta view e o model
  final _controller = CadastroVeiculoController();

  void buttonPressed() async {
    // Uma vez que o formulário de cadastro de um veículo foi
    // preenchido de forma válida e o botão foi pressionado,
    // as informações do veiculo são salvas no model e o usuário é
    // direcionado para o cadastro de perfil.
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      await _controller.save();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CadastroPerfil(), //HomeFretista(),
        ),
        //(route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldTemplate(
      title: _title,
      button: ElevatedButtonTemplate(
        onPressed: buttonPressed,
        buttonText: _buttonText,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: FormFieldTemplate(
                      title: 'Placa',
                      hintText: 'ABC-1234',
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Informe a placa';
                        }
                        return null;
                      },
                      onSaved: _controller.viewModel.changePlaca,
                    ),
                  ),
                  Expanded(
                    child: FormFieldTemplate(
                      title: 'UF',
                      hintText: 'CE',
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Informe a UF';
                        }
                        return null;
                      },
                      onSaved: _controller.viewModel.changeUf,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: FormFieldTemplate(
                      title: 'Código Renavam',
                      hintText: '1234567890',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Informe o renavam';
                        }
                        return null;
                      },
                      onSaved: _controller.viewModel.changeRenavam,
                    ),
                  ),
                  Expanded(
                    child: FormFieldTemplate(
                      title: 'Ano',
                      hintText: '2010',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Informe o ano';
                        }
                        return null;
                      },
                      onSaved: _controller.viewModel.changeAno,
                    ),
                  ),
                ],
              ),
              FormFieldTemplate(
                title: 'Marca/Modelo',
                hintText: 'Chevrolet/S10',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Informe a marca e o modelo';
                  }
                  return null;
                },
                onSaved: _controller.viewModel.changeMarca,
              ),
              FormFieldTemplate(
                title: 'Cor',
                hintText: 'Preto',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Informe a cor';
                  }
                  return null;
                },
                onSaved: _controller.viewModel.changeCor,
              ),
              FormFieldTemplate(
                title: 'Tipo',
                hintText: 'Caminhonte',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Informe o tipo';
                  }
                  return null;
                },
                onSaved: _controller.viewModel.changeTipo,
              ),
              FormFieldTemplate(
                title: 'Capacidade',
                hintText: '1500',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Informe a capacidade';
                  }
                  return null;
                },
                onSaved: _controller.viewModel.changeCapacidade,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
