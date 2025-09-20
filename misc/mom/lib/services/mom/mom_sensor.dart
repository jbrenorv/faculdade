import 'dart:async';
import 'dart:math';

import 'mom_message.dart';
import 'mom_sensor_type.dart';
import '../services.dart';

class MomSensor {
  MomSensor({
    required this.nome,
    required this.momService,
    required this.type,
    required this.topic,
    required this.minValue,
    required this.maxValue,
  });

  final String nome;
  final MomService momService;
  final MomSensorType type;
  final String topic;
  final int minValue;
  final int maxValue;

  final StreamController<int> _streamController = StreamController<int>();
  Timer? _timer;

  int currentValue = 0;

  Stream<int> get onData => _streamController.stream;

  void start() {
    stop();
    
    _timer = Timer.periodic(const Duration(seconds: 2), _timerFn);
  }

  void _timerFn(Timer _) {
    currentValue = generateSensorData();

    if (currentValue < minValue || currentValue > maxValue) {
      momService.publish(
        MomMessage(
          sensorType: type.name,
          topic: topic,
          date: DateTime.now(),
          min: minValue,
          max: maxValue,
          sensorName: nome,
          value: currentValue,
        ),
      );
    }

    _streamController.add(currentValue);
  }

  void stop() {
    _timer?.cancel();
  }

  int generateSensorData() {
    final delta = (maxValue - minValue) ~/ 2;
    
    // Generate a value in [minValue - delta, maxValue + delta]
    return Random().nextInt(maxValue - minValue + 2*delta + 1) + (minValue - delta);
  }
}
