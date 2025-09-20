import 'package:freckt_fretista/utils/responses/default_response.dart';

abstract class IAuthRepository {
  Future<DefaultResponse> doLoginEmailPassword({String email, String password});

  Future<DefaultResponse> registerEmailPassword({
    String email,
    String password,
  });

  Future<DefaultResponse> getUser();

  Future<DefaultResponse> signOut();

  Future<DefaultResponse> checkUserEmail();
}
