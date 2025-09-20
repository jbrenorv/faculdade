// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_cliente.viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CadastroClienteViewModel on _CadastroClienteViewModelBase, Store {
  final _$clickedButtonAtom =
      Atom(name: '_CadastroClienteViewModelBase.clickedButton');

  @override
  bool get clickedButton {
    _$clickedButtonAtom.reportRead();
    return super.clickedButton;
  }

  @override
  set clickedButton(bool value) {
    _$clickedButtonAtom.reportWrite(value, super.clickedButton, () {
      super.clickedButton = value;
    });
  }

  final _$nameAtom = Atom(name: '_CadastroClienteViewModelBase.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$cpfAtom = Atom(name: '_CadastroClienteViewModelBase.cpf');

  @override
  String get cpf {
    _$cpfAtom.reportRead();
    return super.cpf;
  }

  @override
  set cpf(String value) {
    _$cpfAtom.reportWrite(value, super.cpf, () {
      super.cpf = value;
    });
  }

  final _$emailAtom = Atom(name: '_CadastroClienteViewModelBase.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$phoneAtom = Atom(name: '_CadastroClienteViewModelBase.phone');

  @override
  String get phone {
    _$phoneAtom.reportRead();
    return super.phone;
  }

  @override
  set phone(String value) {
    _$phoneAtom.reportWrite(value, super.phone, () {
      super.phone = value;
    });
  }

  final _$passwordAtom = Atom(name: '_CadastroClienteViewModelBase.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$_CadastroClienteViewModelBaseActionController =
      ActionController(name: '_CadastroClienteViewModelBase');

  @override
  void pressButton() {
    final _$actionInfo = _$_CadastroClienteViewModelBaseActionController
        .startAction(name: '_CadastroClienteViewModelBase.pressButton');
    try {
      return super.pressButton();
    } finally {
      _$_CadastroClienteViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeName(String value) {
    final _$actionInfo = _$_CadastroClienteViewModelBaseActionController
        .startAction(name: '_CadastroClienteViewModelBase.changeName');
    try {
      return super.changeName(value);
    } finally {
      _$_CadastroClienteViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeCPF(String value) {
    final _$actionInfo = _$_CadastroClienteViewModelBaseActionController
        .startAction(name: '_CadastroClienteViewModelBase.changeCPF');
    try {
      return super.changeCPF(value);
    } finally {
      _$_CadastroClienteViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeEmail(String value) {
    final _$actionInfo = _$_CadastroClienteViewModelBaseActionController
        .startAction(name: '_CadastroClienteViewModelBase.changeEmail');
    try {
      return super.changeEmail(value);
    } finally {
      _$_CadastroClienteViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changePhone(String value) {
    final _$actionInfo = _$_CadastroClienteViewModelBaseActionController
        .startAction(name: '_CadastroClienteViewModelBase.changePhone');
    try {
      return super.changePhone(value);
    } finally {
      _$_CadastroClienteViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changePassword(String value) {
    final _$actionInfo = _$_CadastroClienteViewModelBaseActionController
        .startAction(name: '_CadastroClienteViewModelBase.changePassword');
    try {
      return super.changePassword(value);
    } finally {
      _$_CadastroClienteViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
clickedButton: ${clickedButton},
name: ${name},
cpf: ${cpf},
email: ${email},
phone: ${phone},
password: ${password}
    ''';
  }
}
