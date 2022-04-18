import 'package:mobxreminders_course/provider/auth_provider.dart';

import '../utils.dart';

class MockAuthProvider implements AuthProvider {
  @override
  Future<bool> deleteAccountAndSignOut() => true.toFuture(oneSecond);

  @override
  Future<bool> login({
    required String email,
    required String password,
  }) =>
      true.toFuture(oneSecond);

  @override
  Future<bool> register({
    required String email,
    required String password,
  }) =>
      true.toFuture(oneSecond);

  @override
  Future<void> signOut() => Future.delayed(oneSecond);

  @override
  String? get userId => 'foobar';
}
