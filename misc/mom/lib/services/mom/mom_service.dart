import 'package:result_dart/result_dart.dart';

import 'mom_message.dart';

abstract class MomService {
  Stream<MomMessage> get onMessage;

  AsyncResult<Unit, String> connect();

  void publish(MomMessage message);

  void subscribe(String topic);

  void unsubscribe(String topic);

  void unsubscribeAll();

  void disconect();
}
