import 'package:freckt_fretista/utils/enums/response_status.dart';
import 'package:freckt_fretista/utils/responses/default_response.dart';

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
