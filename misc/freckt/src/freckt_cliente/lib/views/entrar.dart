import 'package:flutter/material.dart';
import 'package:freckt_cliente/controllers/entrar.controller.dart';
import 'package:freckt_cliente/utils/enums/response_status.dart';
import 'package:freckt_cliente/utils/route_name.dart';
import 'package:freckt_cliente/views/cadastro_cliente.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:freckt_cliente/utils/templates/button_template.dart';

class Entrar extends StatefulWidget {
  @override
  _EntrarState createState() => _EntrarState();
}

class _EntrarState extends State<Entrar> {
  /// Um [bool] para dizer se exibe ou não a senha
  bool _showPassword = false;
  bool _isLoading = false;

  /// Uma [Key] para o estado do [Form] e outra para o [Scaffold]
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  // O controller servirá como uma ponte entre esta view e o model
  final _controller = EntrarController();

  /// Se o preenchimento dos campos [email] e [senha] passaram na
  /// validação, será feita uma tentativa de [login].
  /// No caso de erros será exibido um [SnackBar] com uma mensagem.
  void login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      setState(() {
        _isLoading = true;
      });

      final response = await _controller.login();

      if (response.status == ResponseStatus.SUCCESS) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RouteName.GET_USER_DATA,
          //MaterialPageRoute(
          //  builder: (context) => GetUserData(response.object.uid),
          //),
          (route) => false,
          //arguments: GetUserDataArgs(response.object.uid)
        );
      } else {
        setState(() {
          _isLoading = false;
        });

        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(response.message),
          ),
        );
      }
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Entre ou cadastre-se.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.0, 150.0, 20.0, 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.local_shipping_rounded, size: 34.0),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Freckt',
                    style: GoogleFonts.comfortaa(fontSize: 24.0),
                  ),
                )
              ],
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 5.0, top: 20.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        hintText: 'E-mail',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'informe seu email';
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _controller.viewModel.changeEmail(value);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: !_showPassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
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
                        border: OutlineInputBorder(),
                        hintText: 'Senha',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'informe sua senha';
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _controller.viewModel.changePassword(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
            ButtonTemplate(
              onPressed: _isLoading ? null : login,
              buttonText: 'Entrar',
            ),
            Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('ou'),
                ),
                Expanded(child: Divider()),
              ],
            ),
            InkWell(
              child: Text(
                'Esqueceu sua Senha?',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Ainda não tem uma conta? '),
                InkWell(
                  child: Text(
                    'Cadastre-se',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CadastroCliente(),
                      ),
                    );
                  },
                ),
              ],
            ),
            _isLoading
                ? Container(
                    padding: EdgeInsets.all(40.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
