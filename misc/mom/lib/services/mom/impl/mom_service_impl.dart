import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:result_dart/result_dart.dart';
import 'package:uuid/uuid.dart';

import '../mom_message.dart';
import '../mom_service.dart';

class MomServiceImpl implements MomService {

  static final _kClientIdentifier = const Uuid().v1();
  static const _kBrokerIp = '127.0.0.1';
  static const _kBrokerPort = 1883;

  final Set<String> _subscriptions = {};

  late final MqttServerClient client;

  @override
  AsyncResult<Unit, String> connect() async {
    client = MqttServerClient.withPort(_kBrokerIp, _kClientIdentifier, _kBrokerPort);
    client.setProtocolV311();
    client.keepAlivePeriod = 20;

    try {
      await client.connect();
    } catch (e) {
      client.disconnect();
      return Failure(e.toString());
    }

    if (client.connectionStatus!.state != MqttConnectionState.connected) {
      client.disconnect();
      return Failure('Failed to connect with ActiveMQ, status: ${client.connectionStatus}');
    }

    return Success.unit();
  }

  @override
  void disconect() {
    client.disconnect();
  }

  @override
  Stream<MomMessage> get onMessage => client.updates!.map<MomMessage>(
    (List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final content = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      return MomMessage.fromString(content);
    }
  );

  @override
  void publish(MomMessage message) {
    final builder = MqttClientPayloadBuilder()..addString(message.toString());
    client.publishMessage(message.topic, MqttQos.exactlyOnce, builder.payload!);
  }

  @override
  void subscribe(String topic) {
    client.subscribe(topic, MqttQos.atMostOnce);
    _subscriptions.add(topic);
  }

  @override
  void unsubscribe(String topic) {
    client.unsubscribe(topic);
    _subscriptions.remove(topic);
  }

  @override
  void unsubscribeAll() {
    for (var topic in _subscriptions) {
      unsubscribe(topic);
    }
  }
}
