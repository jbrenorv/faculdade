import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freckt_fretista/models/fretista.model.dart';
import 'package:freckt_fretista/utils/consts.dart';

class Veiculos extends StatefulWidget {
  final model = FretistaModel();

  @override
  _VeiculosState createState() => _VeiculosState();
}

class _VeiculosState extends State<Veiculos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Consts.greenAppBar,
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Veículos'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.only(top: 10.0, bottom: 50.0),
              alignment: Alignment.center,
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.model.getCarroUrl),
                    backgroundColor: Colors.black12,
                    radius: 100.0,
                  ),
                  LimitedBox(
                    child: CircleAvatar(
                      backgroundColor: Consts.greenDark,
                      radius: 30.0,
                      child: IconButton(
                        splashRadius: 10.0,
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        onPressed: () {}, //showBottomSheet,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Placa'),
              subtitle: Text(widget.model.getVehiclePlaca),
            ),
            ListTile(
              title: Text('Marca/Modelo'),
              subtitle: Text(widget.model.getVehicleMarca),
            ),
            ListTile(
              title: Text('Cor'),
              subtitle: Text(widget.model.getVehicleCor),
            ),
            ListTile(
              title: Text('Tipo'),
              subtitle: Text(widget.model.getVehicleTipo),
            ),
            ListTile(
              title: Text('Ano'),
              subtitle: Text(widget.model.getVehicleAno),
            ),
          ],
        ),
      ),
    );
  }
}
