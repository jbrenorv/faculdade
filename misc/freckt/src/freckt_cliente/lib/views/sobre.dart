import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class Ajuda extends StatelessWidget {
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
          title: Text('Ajuda'),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: [
              ListTile(
                title: Text('Termos de Uso'),
                onTap: () {
                  showAlertDialog4(context);
                },
              ),
              ListTile(
                title: Text('Política de Dados'),
                onTap: () {
                  showAlertDialog3(context);
                },
              ),
              ListTile(
              title: Text('Dados do Aplicativo'),
              onTap: (){
                showAlertDialog5(context);
              },
            ), 
            ],
          ),
        ));
  }
}

showAlertDialog3(BuildContext context) {
  // configura o button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  // configura o  AlertDialog
  AlertDialog alerta = AlertDialog(
    title: Text("Política de Dados"),
    content: Text(
      "Esta política descreve as informações que processamos para viabilizar a operação do Freckt. Você pode encontrar informações e ferramentas adicionais nos Termos De Uso do Freckt.",
    ),
    actions: [
      okButton,
    ],
  );
  // exibe o dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}

showAlertDialog4(BuildContext context) {
  // configura o button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  // configura o  AlertDialog
  AlertDialog alerta = AlertDialog(
    title: Text("Termos de Uso"),
    content: Text(
      "Bem-vindo(a) ao Freckt! \nEstes Termos de Uso (ou “Termos”) governam seu uso do Freckt, exceto quando afirmamos explicitamente que outros termos (e não estes) se aplicam, e fornecem informações sobre o Serviço do Freckt (o “Serviço”), descritas abaixo. Quando você cria uma conta do Freckt ou usa a plataforma do Freckt, você concorda com estes termos. Os Termos de Serviço do Google não se aplicam a esse Serviço.O Serviço Freckt é um dos Produtos do Google, fornecido a você pelo Freckt. Estes Termos de Uso, por conseguinte, constituem um acordo entre você e o Freckt.",
    ),
    actions: [
      okButton,
    ],
  );
  // exibe o dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}

showAlertDialog5(BuildContext context) 
{ 
    // configura o button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {Navigator.pop(context);},
  );
  // configura o  AlertDialog
  AlertDialog alerta = AlertDialog(
    title: Text("Dados do Aplicativo"),
    content: Text("Licença: \nSujeito ao cumprimento destes Termos, o Freckt outorga a você uma licença limitada, não exclusiva, não passível de sublicença, revogável e não transferível para: (i) acesso e uso dos Aplicativos em seu dispositivo pessoal, exclusivamente para o seu uso dos Serviços; e (ii) acesso e uso de qualquer conteúdo, informação e material correlato que possa ser disponibilizado por meio dos Serviços, em cada caso, para seu uso pessoal, nunca comercial. Quaisquer direitos não expressamente outorgados por estes Termos são reservados ao Freckt e suas afiliadas licenciadoras.\nRestrições:\nVocê não poderá: (i) remover qualquer aviso de direito autoral, direito de marca ou outro aviso de direito de propriedade de qualquer parte dos Serviços; (ii) reproduzir, modificar, preparar obras derivadas, distribuir, licenciar, locar, vender, revender, transferir, exibir, veicular, transmitir ou, de qualquer outro modo, explorar os Serviços, exceto da forma expressamente permitida pela Uber; (iii) decompilar, realizar engenharia reversa ou desmontar os Serviços, exceto conforme permitido pela legislação aplicável; (iv) conectar, espelhar ou recortar qualquer parte dos Serviços; (v) fazer ou lançar quaisquer programas ou scripts com a finalidade de sobrecarregar ou prejudicar indevidamente a operação e/ou funcionalidade de qualquer aspecto dos Serviços; ou (vi) tentar obter acesso não autorizado aos Serviços ou prejudicar qualquer aspecto dos Serviços ou seus sistemas ou redes correlatas."),
    actions: [
      okButton,
    ],
  );
  // exibe o dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}