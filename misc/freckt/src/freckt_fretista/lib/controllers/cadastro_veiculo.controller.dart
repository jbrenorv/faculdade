import 'package:freckt_fretista/models/fretista.model.dart';
import 'package:freckt_fretista/utils/vehicle.util.dart';
import 'package:freckt_fretista/view-models/cadastro_veiculo.viewmodel.dart';

class CadastroVeiculoController {
  final viewModel = CadastroVeiculoViewModel();
  final model = FretistaModel();

  Future<void> save() async {
    model.addVehicle(
      new Vehicle(
        placa: viewModel.placa,
        uf: viewModel.uf,
        ano: viewModel.ano,
        renavam: viewModel.renavam,
        marca: viewModel.marca,
        cor: viewModel.cor,
        tipo: viewModel.tipo,
        capacidade: viewModel.capacidade,
      ),
    );

    //await model.saveFretistaData();
  }
}
