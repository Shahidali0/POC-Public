import 'package:cricket_poc/lib_exports.dart';

final authRepositoryPr = Provider<AuthRepository>(
  (ref) => AuthRepository(
    authServices: ref.read(authServicesPr),
    localStorage: LocalStorage(),
  ),
);

class AuthRepository {
  final AuthServices _authServices;
  final LocalStorage _localStorage;

  AuthRepository({
    required AuthServices authServices,
    required LocalStorage localStorage,
  })  : _authServices = authServices,
        _localStorage = localStorage;
}
