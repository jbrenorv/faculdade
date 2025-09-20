import 'package:mobx/mobx.dart';
part 'cadastro_fretista.viewmodel.g.dart';

class CadastroFretistaViewModel = _CadastroFretistaViewModelBase
    with _$CadastroFretistaViewModel;

abstract class _CadastroFretistaViewModelBase with Store {
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
  String cnh = '';
  @action
  void changeCNH(String value) => cnh = value;

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
