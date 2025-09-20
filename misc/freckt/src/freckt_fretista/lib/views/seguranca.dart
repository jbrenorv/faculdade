import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:freckt_fretista/utils/consts.dart';
import 'package:freckt_fretista/utils/templates/elevated_button_template.dart';
import 'package:freckt_fretista/utils/templates/form_field_template.dart';
//import 'package:teste/faleconosco.dart';

class Seguranca extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Consts.greenAppBar,
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Segurança',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FormFieldTemplate(
              title: 'Senha atual',
              hintText: '•••••',
              keyboardType: TextInputType.text,
            ),
            FormFieldTemplate(
              title: 'Nova senha',
              hintText: '•••••',
              keyboardType: TextInputType.text,
            ),
            FormFieldTemplate(
              title: 'Repita a nova senha',
              hintText: '•••••',
              keyboardType: TextInputType.text,
            ),
            InkWell(
              onTap: () {
                showAlertDialog2(context);
              },
              child: Text(
                'Esqueceu sua Senha?',
                //style: TextStyle(color: Consts.frecktThemeColor),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              child: ElevatedButtonTemplate(
                buttonText: "Salvar",
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // The InkWell wraps the custom flat button widget.
    return InkWell(
      // When the user taps the button, show a snackbar.
      onTap: () {
        showAlertDialog2(context);
      },
      child: Text(
                'Esqueceu sua Senha?',
                style: TextStyle(color: Colors.teal[400]),
                textAlign: TextAlign.start,
              ),
    );
  }
}*/

showAlertDialog2(BuildContext context) {
  Widget cancelaButton = FlatButton(
    child: Text("Reenviar"),
    onPressed: () {},
  );
  Widget continuaButton = FlatButton(
    child: Text("Ok"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  //configura o AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Email de redefinição de senha enviado!"),
    content: Text(
        "Enviamos instruções para redefinição de senha para seu email.  \n\nNão recebeu o email?"),
    actions: [
      cancelaButton,
      continuaButton,
    ],
  );
  //exibe o diálogo
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
