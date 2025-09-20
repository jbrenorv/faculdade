// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_fretista.viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CadastroFretistaViewModel on _CadastroFretistaViewModelBase, Store {
  final _$clickedButtonAtom =
      Atom(name: '_CadastroFretistaViewModelBase.clickedButton');

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

  final _$nameAtom = Atom(name: '_CadastroFretistaViewModelBase.name');

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

  final _$cpfAtom = Atom(name: '_CadastroFretistaViewModelBase.cpf');

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

  final _$cnhAtom = Atom(name: '_CadastroFretistaViewModelBase.cnh');

  @override
  String get cnh {
    _$cnhAtom.reportRead();
    return super.cnh;
  }

  @override
  set cnh(String value) {
    _$cnhAtom.reportWrite(value, super.cnh, () {
      super.cnh = value;
    });
  }

  final _$emailAtom = Atom(name: '_CadastroFretistaViewModelBase.email');

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

  final _$phoneAtom = Atom(name: '_CadastroFretistaViewModelBase.phone');

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

  final _$passwordAtom = Atom(name: '_CadastroFretistaViewModelBase.password');

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

  final _$_CadastroFretistaViewModelBaseActionController =
      ActionController(name: '_CadastroFretistaViewModelBase');

  @override
  dynamic pressButton() {
    final _$actionInfo = _$_CadastroFretistaViewModelBaseActionController
        .startAction(name: '_CadastroFretistaViewModelBase.pressButton');
    try {
      return super.pressButton();
    } finally {
      _$_CadastroFretistaViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeName(String value) {
    final _$actionInfo = _$_CadastroFretistaViewModelBaseActionController
        .startAction(name: '_CadastroFretistaViewModelBase.changeName');
    try {
      return super.changeName(value);
    } finally {
      _$_CadastroFretistaViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeCPF(String value) {
    final _$actionInfo = _$_CadastroFretistaViewModelBaseActionController
        .startAction(name: '_CadastroFretistaViewModelBase.changeCPF');
    try {
      return super.changeCPF(value);
    } finally {
      _$_CadastroFretistaViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeCNH(String value) {
    final _$actionInfo = _$_CadastroFretistaViewModelBaseActionController
        .startAction(name: '_CadastroFretistaViewModelBase.changeCNH');
    try {
      return super.changeCNH(value);
    } finally {
      _$_CadastroFretistaViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeEmail(String value) {
    final _$actionInfo = _$_CadastroFretistaViewModelBaseActionController
        .startAction(name: '_CadastroFretistaViewModelBase.changeEmail');
    try {
      return super.changeEmail(value);
    } finally {
      _$_CadastroFretistaViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changePhone(String value) {
    final _$actionInfo = _$_CadastroFretistaViewModelBaseActionController
        .startAction(name: '_CadastroFretistaViewModelBase.changePhone');
    try {
      return super.changePhone(value);
    } finally {
      _$_CadastroFretistaViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changePassword(String value) {
    final _$actionInfo = _$_CadastroFretistaViewModelBaseActionController
        .startAction(name: '_CadastroFretistaViewModelBase.changePassword');
    try {
      return super.changePassword(value);
    } finally {
      _$_CadastroFretistaViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
clickedButton: ${clickedButton},
name: ${name},
cpf: ${cpf},
cnh: ${cnh},
email: ${email},
phone: ${phone},
password: ${password}
    ''';
  }
}
