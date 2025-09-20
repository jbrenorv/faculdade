import 'package:firebase_auth/firebase_auth.dart';
import 'package:freckt_fretista/utils/interfaces/auth_repository.interface.dart';
import 'package:freckt_fretista/utils/responses/default_response.dart';
import 'package:freckt_fretista/utils/responses/response_builder.dart';

class AccountRepository implements IAuthRepository {
  final firebaseAuth = FirebaseAuth.instance;

  @override
  Future<DefaultResponse> doLoginEmailPassword({
    String email,
    String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      return ResponseBuilder.success<User>(object: firebaseAuth.currentUser);
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'user-not-found':
          {
            message = 'No user found for that email';
          }
          break;
        case 'wrong-password':
          {
            message = 'Wrong password provided for that user';
          }
          break;
        default:
          {
            message = 'há algo errado';
          }
          break;
      }

      return ResponseBuilder.failed(message: message);
    } catch (e) {
      return ResponseBuilder.failed(message: 'há algo errado');
    }
  }

  @override
  Future<DefaultResponse> getUser() async {
    try {
      return ResponseBuilder.success<User>(object: firebaseAuth.currentUser);
    } catch (e) {
      return ResponseBuilder.failed(message: 'há algo errado');
    }
  }

  @override
  Future<DefaultResponse> signOut() async {
    try {
      await firebaseAuth.signOut();
      return ResponseBuilder.success(message: 'saiu com sucesso');
    } catch (e) {
      return ResponseBuilder.failed(message: 'algo deu errado');
    }
  }

  @override
  Future<DefaultResponse> registerEmailPassword({
    String email,
    String password,
  }) async {
    try {
      return await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((auth) {
        //firebaseAuth.setPersistence(Persistence.LOCAL);
        return ResponseBuilder.success<User>(object: auth.user);
      });
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'weak-password':
          {
            message = 'The password provided is too weak.';
          }
          break;
        case 'email-already-in-use':
          {
            message = 'The account already exists for that email.';
          }
          break;
        default:
          {
            message = 'há algo errado';
          }
          break;
      }

      return ResponseBuilder.failed(message: message);
    } catch (e) {
      return ResponseBuilder.failed(message: 'há algo errado');
    }
  }

  @override
  Future<DefaultResponse> checkUserEmail() async {
    User user = firebaseAuth.currentUser;

    if (!user.emailVerified) {
      try {
        await user.sendEmailVerification();
        return ResponseBuilder.success(message: 'email enviado');
      } catch (e) {
        return ResponseBuilder.failed(message: 'há algo errado');
      }
    }
    return ResponseBuilder.failed(message: 'já foi verificado antes');
  }
}
