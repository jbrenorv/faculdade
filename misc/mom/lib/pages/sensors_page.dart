import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/mom/mom_sensor.dart';
import '../services/mom/mom_sensor_type.dart';
import '../services/mom/mom_service.dart';
import '../utils/constants.dart';
import '../widgets/add_sensor_dialog_widget.dart';

class SensorsPage extends StatefulWidget {
  const SensorsPage({super.key});

  @override
  State<SensorsPage> createState() => _SensorsPageState();
}

class _SensorsPageState extends State<SensorsPage> {
  final List<MomSensor> _sensors = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensores'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddSensorDialog,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: _sensors.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.sensors),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    'Tipo: ${_sensors[index].type.name.toUpperCase()}',
                  ),
                ),
                Expanded(
                  child: Text(
                    'Tópico: ${_sensors[index].topic}',
                  ),
                ),
                Expanded(
                  child: Text(
                    'Nome: ${_sensors[index].nome}',
                  ),
                ),
                Expanded(
                  child: Text(
                    'Limites: ${_sensors[index].minValue} - ${_sensors[index].maxValue}',
                  ),
                ),
              ],
            ),
            trailing: StreamBuilder<int>(
              stream: _sensors[index].onData,
              builder: (context, snapshot) {
                if (snapshot.data == null) return const Text('');

                Color? color;
                if (snapshot.data! < _sensors[index].minValue || snapshot.data! > _sensors[index].maxValue) {
                  color = Colors.red;
                }

                return Text(
                  snapshot.data.toString(),
                  style: TextStyle(color: color),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _showAddSensorDialog() {

    const double rangeMin = 30.0;
    const double rangeMax = 60.0;

    RangeValues selectedRange = const RangeValues(rangeMin, rangeMax);
    MomSensorType selectedType = MomSensorType.umidade;

    final nameController = TextEditingController();
    final topicController = TextEditingController();
    onRangeChanged(RangeValues range) {
      selectedRange = range;
    }
    onTypeChanged(MomSensorType? type) {
      if (type != null) {
        selectedType = type;
      }
    }
    addSensor() {
      final sensor = MomSensor(
        momService: context.read<MomService>(),
        nome: nameController.text,
        topic: Constants.topicPrefix + topicController.text,
        type: selectedType,
        minValue: selectedRange.start.toInt(),
        maxValue: selectedRange.end.toInt(),
      );
      sensor.start();
      setState(() {
        _sensors.add(sensor);
      });
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Adicinar sensor'),
          content: AddSensorDialogWidget(
            nameController: nameController,
            topicController: topicController,
            onRangeChanged: onRangeChanged,
            onTypeChanged: onTypeChanged,
            rangeMin: rangeMin,
            rangeMax: rangeMax,
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                addSensor();
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }
}
