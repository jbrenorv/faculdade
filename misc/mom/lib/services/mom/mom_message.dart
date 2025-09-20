import 'dart:convert';

class MomMessage {
  MomMessage({
    required this.topic,
    required this.sensorName,
    required this.sensorType,
    required this.min,
    required this.max,
    required this.date,
    required this.value,
  });

  final String topic;
  final String sensorName;
  final String sensorType;
  final int min;
  final int max;
  final DateTime date;
  final int value;

  @override
  String toString() {
    final m = {
      'topic': topic,
      'sensorName': sensorName,
      'sensorType': sensorType,
      'min': min,
      'max': max,
      'date': date.millisecondsSinceEpoch,
      'value': value,
    };
    return jsonEncode(m);
  }

  factory MomMessage.fromString(String s) {
    final m = jsonDecode(s) as Map<String, dynamic>;
    return MomMessage(
      topic: m['topic'],
      sensorName: m['sensorName'],
      sensorType: m['sensorType'],
      min: m['min'],
      max: m['max'],
      date: DateTime.fromMillisecondsSinceEpoch(m['date']),
      value: m['value'],
    );
  }
}
