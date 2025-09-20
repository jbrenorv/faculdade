import 'dart:io';

import 'package:freckt_cliente/models/cliente.model.dart';
import 'package:freckt_cliente/utils/templates/elevated_button_template.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:freckt_cliente/views/verify_email.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';

class CadastroPerfil extends StatefulWidget {
  @override
  _CadastroPerfilState createState() => _CadastroPerfilState();
}

class _CadastroPerfilState extends State<CadastroPerfil> {
  File _picture;
  String photoPath;
  String photoUrl;
  bool _isLoading = false;

  final picker = ImagePicker();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final model = ClienteModel();

  void showSnackBar(String info) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(info),
      ),
    );
  }

  Future getImage({@required bool camera}) async {
    Navigator.pop(context);

    final pickedFile = await picker.getImage(
      source: camera ? ImageSource.camera : ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(
        () {
          _picture = File(pickedFile.path);
        },
      );
    }
  }

  void showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FlatButton(
              onPressed: () {
                getImage(camera: true);
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
                getImage(camera: false);
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

  void uploadPhoto() async {
    if (_picture == null) {
      showSnackBar('É necessário adicionar uma foto de perfil.');
    } else {
      try {
        setState(() {
          _isLoading = true;
        });

        photoPath =
            'clientes/${model.getUserId}/foto-perfil${p.extension(_picture.path)}';

        await firebase_storage.FirebaseStorage.instance
            .ref(photoPath)
            .putFile(_picture);

        photoUrl = await firebase_storage.FirebaseStorage.instance
            .ref(photoPath)
            .getDownloadURL();

        model.setProfileData(
          uPhotoPath: photoPath,
          uPhotoUrl: photoUrl,
        );

        await model.saveUserData();

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyEmailScreen(),
          ),
          (route) => false,
        );
      } on firebase_storage.FirebaseException catch (e) {
        setState(() {
          _isLoading = false;
        });

        showSnackBar('Algo deu errado. Erro: ${e.code}.');
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
          'Cadastrar Perfil',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 50.0, bottom: 100.0),
              alignment: Alignment.center,
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  CircleAvatar(
                    backgroundImage: _picture == null
                        ? AssetImage('images/sem-foto-perfil.png')
                        : FileImage(_picture),
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
                        onPressed: showBottomSheet,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.label_important_outline_rounded),
              title: Text('Requisitos'),
              subtitle: Text(
                'A foto deve ser de boa qualidade, em um lugar bem iluminado e mostrando seu rosto.',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButtonTemplate(
        buttonText: 'Próximo',
        onPressed: _isLoading ? null : uploadPhoto,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
