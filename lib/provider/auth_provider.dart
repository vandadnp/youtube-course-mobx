import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobxreminders_course/auth/auth_error.dart';

abstract class AuthProvider {
  String? get userId;
  Future<bool> deleteAccountAndSignOut();
  Future<void> signOut();
  Future<bool> register({
    required String email,
    required String password,
  });
  Future<bool> login({
    required String email,
    required String password,
  });
}

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<bool> deleteAccountAndSignOut() async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user == null) {
      return false;
    }
    try {
      // delete the user
      await user.delete();
      // log the user out
      await auth.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      throw AuthError.from(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthError.from(e);
    }
    return FirebaseAuth.instance.currentUser != null;
  }

  @override
  Future<bool> register({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthError.from(e);
    }
    return FirebaseAuth.instance.currentUser != null;
  }

  @override
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (_) {
      // we are ignoring the errors here
    }
  }

  @override
  String? get userId => FirebaseAuth.instance.currentUser?.uid;
}
