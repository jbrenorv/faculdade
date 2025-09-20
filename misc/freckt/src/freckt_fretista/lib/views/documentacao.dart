import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freckt_fretista/views/verificacao.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as p;

import '../models/fretista.model.dart';
import '../utils/templates/elevated_button_template.dart';

class Documentacao extends StatefulWidget {
  @override
  _DocumentacaoState createState() => _DocumentacaoState();
}

class _DocumentacaoState extends State<Documentacao> {
  File _cnh, _licenciamento, _carro;
  String cnhPath, licenciamentoPath, carroPath;
  String cnhUrl, licenciamentoUrl, carroUrl;
  bool _isLoading = false;

  final picker = ImagePicker();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final model = FretistaModel();

  void showSnackBar({String info = 'Forneça todas as fotos solicitadas.'}) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(info),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future getImage({@required bool camera, @required int opt}) async {
    Navigator.pop(context);

    final pickedFile = await picker.getImage(
      source: camera ? ImageSource.camera : ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(
        () {
          switch (opt) {
            case 1:
              _cnh = File(pickedFile.path);
              break;
            case 2:
              _licenciamento = File(pickedFile.path);
              break;
            default:
              _carro = File(pickedFile.path);
          }
        },
      );
    }
  }

  void showBottomSheet(int opt) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FlatButton(
              onPressed: () {
                getImage(camera: true, opt: opt);
              },
              child: ListTile(
                leading: Icon(Icons.camera_alt_rounded),
                title: Text(
                  'Câmera',
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                getImage(camera: false, opt: opt);
              },
              child: ListTile(
                leading: Icon(Icons.crop_original_rounded),
                title: Text(
                  'Galeria',
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  bool allRight() => (_cnh != null && _licenciamento != null && _carro != null);

  void uploadPhotos() async {
    if (!allRight()) {
      showSnackBar();
    } else {
      setState(() {
        _isLoading = true;
      });

      try {
        cnhPath =
            'fretistas/${model.getUserId}/foto-cnh${p.extension(_cnh.path)}';
        licenciamentoPath =
            'fretistas/${model.getUserId}/foto-licenciamento${p.extension(_licenciamento.path)}';
        carroPath =
            'fretistas/${model.getUserId}/foto-veiculo${p.extension(_carro.path)}';

        final storage = firebase_storage.FirebaseStorage.instance;

        await storage.ref(cnhPath).putFile(_cnh);
        await storage.ref(licenciamentoPath).putFile(_licenciamento);
        await storage.ref(carroPath).putFile(_carro);

        cnhUrl = await storage.ref(cnhPath).getDownloadURL();
        licenciamentoUrl =
            await storage.ref(licenciamentoPath).getDownloadURL();
        carroUrl = await storage.ref(carroPath).getDownloadURL();

        model.setDocumentationData(
          uCnhPath: cnhPath,
          uLicenciamentoPath: licenciamentoPath,
          uCarroPath: carroPath,
          uCnhUrl: cnhUrl,
          uLicenciamentoUrl: licenciamentoUrl,
          uCarroUrl: carroUrl,
        );

        await model.saveFretistaData();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Verificacao(),
          ),
        );
      } on firebase_storage.FirebaseException catch (e) {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(info: 'Algo deu errado. Erro: ${e.code}.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 4.0),
          child: _isLoading
              ? LinearProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                )
              : Container(),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Documentação',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        height: 50.0,
      ),
      floatingActionButton: ElevatedButtonTemplate(
        buttonText: 'Verificar',
        onPressed: _isLoading ? null : uploadPhotos,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 20.0,
          left: 10.0,
          right: 10.0,
          bottom: 75.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(10.0),
              //leading: Icon(Icons.label_important_outline_rounded),
              title: Text(
                  'Faça o upload dos documentos pedidos abaixo para verificação.'),
              subtitle: Text(
                'Requisitos: As fotos devem ser de boa qualidade, em um lugar bem iluminado.',
              ),
            ),
            Text('CNH com EAR'),
            Container(
              padding: EdgeInsets.only(top: 10.0, bottom: 30.0),
              alignment: Alignment.center,
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  CircleAvatar(
                    ////backgroundImage: AssetImage('images/upload-foto.png'),
                    backgroundImage: _cnh == null
                        ? AssetImage('images/upload-foto.png')
                        : FileImage(_cnh),
                    backgroundColor: Colors.white,
                    radius: 100.0,
                  ),
                  LimitedBox(
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 30.0,
                      child: IconButton(
                        splashRadius: 10.0,
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showBottomSheet(1);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text('Certificado de Registro e Licenciamento de Veículo '),
            Container(
              padding: EdgeInsets.only(top: 10.0, bottom: 30.0),
              alignment: Alignment.center,
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  CircleAvatar(
                    backgroundImage: _licenciamento == null
                        ? AssetImage('images/upload-foto.png')
                        : FileImage(_licenciamento),
                    backgroundColor: Colors.white,
                    radius: 100.0,
                  ),
                  LimitedBox(
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 30.0,
                      child: IconButton(
                        splashRadius: 10.0,
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showBottomSheet(2);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text('Foto do Veículo com a placa'),
            Container(
              padding: EdgeInsets.only(top: 10.0, bottom: 30.0),
              alignment: Alignment.center,
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  CircleAvatar(
                    backgroundImage: _carro == null
                        ? AssetImage('images/upload-foto.png')
                        : FileImage(_carro),
                    backgroundColor: Colors.white,
                    radius: 100.0,
                  ),
                  LimitedBox(
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 30.0,
                      child: IconButton(
                        splashRadius: 10.0,
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showBottomSheet(3);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
