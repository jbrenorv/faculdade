import 'package:freckt_fretista/utils/enums/response_status.dart';

class DefaultResponse<T> {
  final T object;
  final String message;
  final ResponseStatus status;

  const DefaultResponse({this.object, this.message, this.status});
}
