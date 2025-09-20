import 'package:cpfcnpj/cpfcnpj.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freckt_fretista/models/fretista.model.dart';
import 'package:freckt_fretista/utils/responses/default_response.dart';
import 'package:freckt_fretista/view-models/cadastro_fretista.viewmodel.dart';

class CadastroFretistaController {
  final viewModel = CadastroFretistaViewModel();
  final model = FretistaModel();

  String validateName() {
    if (viewModel.name.isEmpty && viewModel.clickedButton) {
      return 'É necessário informar seu nome';
    }
    return null;
  }

  String validateCPF() {
    if (viewModel.clickedButton) {
      if (viewModel.cpf.isEmpty) {
        return 'É necessário informar seu cpf';
      } else if (!CPF.isValid(viewModel.cpf)) {
        return 'CPF inválido';
      }
    }

    return null;
  }

  String validateCNH() {
    return null;
  }

  String validateEmail() {
    if (viewModel.clickedButton) {
      if (viewModel.email.isEmpty) {
        return 'É necessário informar seu e-mail';
      } else if (!EmailValidator.validate(viewModel.email)) {
        return 'E-mail inválido';
      }
    }

    return null;
  }

  String validatePhone() {
    return null;
  }

  String validatePassword() {
    if (viewModel.clickedButton) {
      if (viewModel.password.isEmpty) {
        return 'É necessário criar uma senha';
      } else if (viewModel.password.length < 6) {
        return 'Deve ter no mínimo 6 caracteres';
      }
    }

    return null;
  }

  void save() {
    model.setRegistrationData(viewModel);
  }

  void uploadData() {
    model.saveRegistrationData();
  }

  // Pensar em um jeito melhor depois
  //
  bool validate() {
    return (validateName() == null &&
        validateCPF() == null &&
        validateCNH() == null &&
        validateEmail() == null &&
        validatePhone() == null &&
        validatePassword() == null);
  }

  Future<DefaultResponse<User>> register() async {
    return await model.createFretistaAccount(
      uEmail: viewModel.email,
      uPassword: viewModel.password,
    );
  }
}
