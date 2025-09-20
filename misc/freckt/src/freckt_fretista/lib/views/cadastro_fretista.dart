import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freckt_fretista/controllers/cadastro_fretista.controller.dart';
import 'package:freckt_fretista/utils/templates/elevated_button_template.dart';
import 'package:freckt_fretista/utils/templates/form_field_template.dart';
import 'package:freckt_fretista/utils/templates/scaffold_template.dart';
import 'package:freckt_fretista/utils/enums/response_status.dart';
import 'package:freckt_fretista/views/cadastro_veiculo.dart';

class CadastroFretista extends StatefulWidget {
  @override
  _CadastroFretistaState createState() => _CadastroFretistaState();
}

class _CadastroFretistaState extends State<CadastroFretista> {
  static const String _title = 'Cadastrar Fretista';
  static const String _buttonText = 'Próximo';

  bool _showPassword = false;
  bool _isLoading = false;

  /// Uma [Key] para o estado do [Form] e outra para o [Scaffold]
  //final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // O controller servirá como uma ponte entre esta view e o model
  final _controller = CadastroFretistaController();

  void register() async {
    // Muda o estado do botão para 'já pressionado'.Isso serve para o
    // MobX não apresentar qualquer erro na validação dos campos
    // do formulário, antes que o botão seja pressionado.
    _controller.viewModel.pressButton();

    // Se todos os campos foram preenchidos de forma válida, os dados
    // serão salvos e será criada uma conta com o email e a senha
    // informados e o usuário será direcionado para o cadastro de um
    // veículo.
    if (_controller.validate()) {
      setState(() {
        _isLoading = true;
      });

      final response = await _controller.register();
      _controller.save();

      if (response.status == ResponseStatus.SUCCESS) {
        _controller.uploadData();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CadastroVeiculo(),
          ),
        );
      } else {
        setState(() {
          _isLoading = false;
        });

        /// Esta [SnackBar] não está ficando visível quando devia.
        /// o problema possivelmente é no [ScaffoldTenplate].
        /// Corrigir isso o mais breve!!
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(response.message),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldTemplate(
      key: _scaffoldKey,
      title: _title,
      isLoading: _isLoading,
      button: ElevatedButtonTemplate(
        onPressed: _isLoading ? null : register,
        buttonText: _buttonText,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
        child: Form(
          //key: _formKey,
          child: Column(
            children: [
              Observer(
                builder: (_) => FormFieldTemplate(
                  title: 'Nome',
                  hintText: 'José',
                  keyboardType: TextInputType.name,
                  errorText: _controller.validateName(),
                  onChanged: _controller.viewModel.changeName,
                ),
              ),
              Observer(
                builder: (_) => FormFieldTemplate(
                  title: 'CPF',
                  hintText: '12345678900',
                  keyboardType: TextInputType.number,
                  errorText: _controller.validateCPF(),
                  onChanged: _controller.viewModel.changeCPF,
                ),
              ),
              //Observer(
              //  builder: (_) =>
              FormFieldTemplate(
                title: 'CNH',
                hintText: '123456789',
                keyboardType: TextInputType.number,
                //errorText: _controller.validateCNH(),
                onChanged: _controller.viewModel.changeCNH,
              ),
              //),
              Observer(
                builder: (_) => FormFieldTemplate(
                  title: 'E-mail',
                  hintText: 'jose@email.com',
                  keyboardType: TextInputType.emailAddress,
                  errorText: _controller.validateEmail(),
                  onChanged: _controller.viewModel.changeEmail,
                ),
              ),
              //Observer(
              //  builder: (_) =>
              FormFieldTemplate(
                title: 'Telefone',
                hintText: '(85) 98888-8888',
                keyboardType: TextInputType.phone,
                //errorText: _controller.validatePhone(),
                onChanged: _controller.viewModel.changePhone,
              ),
              //),
              //Observer(
              //  builder: (_) => FormFieldTemplate(
              //    title: 'Senha',
              //    hintText: 'Crie uma senha',
              //    obscureText: true,
              //    keyboardType: TextInputType.text,
              //    errorText: _controller.validatePassword(),
              //    onChanged: _controller.viewModel.changePassword,
              //  ),
              //),
              Observer(
                builder: (_) => Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Senha'),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: !_showPassword,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            child: Icon(
                              _showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          errorText: _controller.validatePassword(),
                          border: OutlineInputBorder(),
                          hintText: 'Crie uma senha',
                        ),
                        onChanged: _controller.viewModel.changePassword,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
