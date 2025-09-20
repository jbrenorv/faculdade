import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:freckt_cliente/repositories/account.repository.dart';
import 'package:freckt_cliente/utils/enums/response_status.dart';
import 'package:freckt_cliente/utils/responses/default_response.dart';
import 'package:freckt_cliente/view-models/cadastro_cliente.viewmodel.dart';

class ClienteModel {
  String id = '';
  String name = '';
  String cpf = '';
  String email = '';
  String phone = '';
  String password = '';
  String photoUrl = '';
  String photoPath = '';

  final _repository = AccountRepository();

  /// Para o model é usado um contrutor [factory] para que sempre
  /// que instanciado, seja o mesmo objeto model.
  static final ClienteModel _clienteModel = ClienteModel._internal();

  factory ClienteModel() {
    return _clienteModel;
  }

  ClienteModel._internal();

  String get getUserId => id;
  String get getUserName => name;
  String get getUserPhone => phone;
  String get getUserEmail => email;
  String get getPhotoUrl => photoUrl;

  void setRegistrationData(CadastroClienteViewModel viewModel) {
    name = viewModel.name;
    cpf = viewModel.cpf;
    email = viewModel.email;
    phone = viewModel.phone;
    password = viewModel.password;
  }

  void setProfileData({String uPhotoPath, String uPhotoUrl}) {
    photoPath = uPhotoPath;
    photoUrl = uPhotoUrl;
  }

  /// Recebe os dados vindos do [FirebaseFirestore] e os coloca
  /// nos atributos adequadamente.
  void loadDataFromFirestore({@required Map<String, dynamic> data}) {
    id = data['id'];
    name = data['name'];
    cpf = data['cpf'];
    email = data['email'];
    phone = data['phone'];
    password = data['password'];
    photoPath = data['photoPath'];
    photoUrl = data['photoUrl'];
  }

  void loadRegistrationData({@required Map<String, dynamic> data}) {
    id = data['id'];
    name = data['name'];
    cpf = data['cpf'];
    email = data['email'];
    phone = data['phone'];
    password = data['password'];
  }

  /// Usado no ato de um cadastro. Salva dos dados no [FirebaseFirestore]
  Future<void> saveUserData() async {
    Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'cpf': cpf,
      'email': email,
      'phone': phone,
      'password': password,
      'photoPath': photoPath,
      'photoUrl': photoUrl,
      'completeRegistration': true
    };
    await FirebaseFirestore.instance.collection('clientes').doc(id).set(data);
  }

  Future<void> saveRegistrationData() async {
    Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'cpf': cpf,
      'email': email,
      'phone': phone,
      'password': password,
      'completeRegistration': false
    };
    await FirebaseFirestore.instance.collection('clientes').doc(id).set(data);
  }

  // Este metodo salva aqui no model os dados do usuário quando ele está
  // se cadastrando.

  /// Solicita ao [repository] a criação de uma nova conta
  /// via email e senha.
  Future<DefaultResponse> createUserAccount({
    @required String uEmail,
    @required String uPassword,
  }) async {
    final response = await _repository.registerEmailPassword(
      email: uEmail,
      password: uPassword,
    );

    if (response.status == ResponseStatus.SUCCESS) {
      id = response.object.uid;
    }

    return response;
  }

  /// Solicita ao [repository] um login via email e senha.
  Future<DefaultResponse> loginUserAccount({
    @required String uEmail,
    @required String uPassword,
  }) async {
    final response = await _repository.doLoginEmailPassword(
      email: uEmail,
      password: uPassword,
    );

    return response;
  }

  // Siplesmente faz o logout do atual usuário autenticado.
  Future<DefaultResponse> signOutUser() async {
    return await _repository.signOut();
  }
}
