import 'package:freckt_cliente/models/cliente.model.dart';
import 'package:freckt_cliente/utils/responses/default_response.dart';
import 'package:freckt_cliente/view-models/entrar.viewmodel.dart';

class EntrarController {
  final viewModel = EntrarViewModel();
  final model = ClienteModel();

  Future<DefaultResponse> login() async {
    return await model.loginUserAccount(
      uEmail: viewModel.email,
      uPassword: viewModel.password,
    );
  }
}
