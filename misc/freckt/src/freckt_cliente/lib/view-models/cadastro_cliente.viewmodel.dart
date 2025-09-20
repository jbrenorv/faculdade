import 'package:mobx/mobx.dart';
part 'cadastro_cliente.viewmodel.g.dart';

class CadastroClienteViewModel = _CadastroClienteViewModelBase
    with _$CadastroClienteViewModel;

abstract class _CadastroClienteViewModelBase with Store {
  @observable
  bool clickedButton = false;
  @action
  void pressButton() => clickedButton = true;

  @observable
  String name = '';
  @action
  void changeName(String value) => name = value;

  @observable
  String cpf = '';
  @action
  void changeCPF(String value) => cpf = value;

  @observable
  String email = '';
  @action
  void changeEmail(String value) => email = value;

  @observable
  String phone = '';
  @action
  void changePhone(String value) => phone = value;

  @observable
  String password = '';
  @action
  void changePassword(String value) => password = value;
}
