import 'package:mobx/mobx.dart';
part 'cadastro_veiculo.viewmodel.g.dart';

class CadastroVeiculoViewModel = _CadastroVeiculoViewModelBase
    with _$CadastroVeiculoViewModel;

abstract class _CadastroVeiculoViewModelBase with Store {
  @observable
  bool clickedButton = false;
  @action
  void pressButton() => clickedButton = true;

  @observable
  String placa = '';
  @action
  void changePlaca(String value) => placa = value;

  @observable
  String renavam = '';
  @action
  void changeRenavam(String value) => renavam = value;

  @observable
  String uf = '';
  @action
  void changeUf(String value) => uf = value;

  @observable
  String ano = '';
  @action
  void changeAno(String value) => ano = value;

  @observable
  String marca = '';
  @action
  void changeMarca(String value) => marca = value;

  @observable
  String cor = '';
  @action
  void changeCor(String value) => cor = value;

  @observable
  String tipo = '';
  @action
  void changeTipo(String value) => tipo = value;

  @observable
  String capacidade = '';
  @action
  void changeCapacidade(String value) => capacidade = value;
}
