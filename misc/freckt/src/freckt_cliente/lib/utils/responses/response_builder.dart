import 'package:freckt_cliente/utils/enums/response_status.dart';
import 'package:freckt_cliente/utils/responses/default_response.dart';

class ResponseBuilder {
  static DefaultResponse failed<T>({T object, String message}) {
    return DefaultResponse<T>(
      object: object,
      message: message,
      status: ResponseStatus.FAILED,
    );
  }

  static DefaultResponse success<T>({T object, String message}) {
    return DefaultResponse<T>(
      object: object,
      message: message,
      status: ResponseStatus.SUCCESS,
    );
  }
}
