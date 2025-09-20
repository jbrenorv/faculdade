import 'package:flutter/material.dart';
import 'package:mom/utils/constants.dart';

import '../services/mom/mom_sensor_type.dart';

class AddSensorDialogWidget extends StatefulWidget {
  const AddSensorDialogWidget({
    super.key,
    required this.rangeMin,
    required this.rangeMax,
    required this.nameController,
    required this.topicController,
    required this.onRangeChanged,
    required this.onTypeChanged,
  });

  final double rangeMin;
  final double rangeMax;
  final TextEditingController nameController;
  final TextEditingController topicController;
  final ValueChanged<RangeValues> onRangeChanged;
  final ValueChanged<MomSensorType?> onTypeChanged;

  @override
  State<AddSensorDialogWidget> createState() => _AddSensorDialogWidgetState();
}

class _AddSensorDialogWidgetState extends State<AddSensorDialogWidget> {
  late RangeValues _rangeValues;

  @override
  void initState() {
    _rangeValues = RangeValues(widget.rangeMin, widget.rangeMax);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16.0),
          TextField(
            controller: widget.nameController,
            decoration: const InputDecoration(
              label: Text('Nome'),
              border: OutlineInputBorder(),
              hintText: 'Sensor de pressão 1AX03B',
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: widget.topicController,
            decoration: const InputDecoration(
              label: Text('Tópico'),
              border: OutlineInputBorder(),
              prefixText: Constants.topicPrefix,
            ),
          ),
          const SizedBox(height: 16.0),
          DropdownMenu<MomSensorType>(
            label: const Text('Tipo'),
            onSelected: widget.onTypeChanged,
            dropdownMenuEntries: List.of(
              MomSensorType.values.map(
                (type) {
                  return DropdownMenuEntry(
                    value: type,
                    label: type.name.toUpperCase(),
                  );
                }
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          RangeSlider(
            values: _rangeValues,
            min: widget.rangeMin.toDouble(),
            max: widget.rangeMax.toDouble(),
            divisions: 10,
            onChanged: (range) {
              setState(() {
                _rangeValues = range;
              });
              widget.onRangeChanged(range);
            },
          ),
          const SizedBox(height: 16.0),
          Text('Limites: ${_rangeValues.start.toInt()} - ${_rangeValues.end.toInt()}'),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
