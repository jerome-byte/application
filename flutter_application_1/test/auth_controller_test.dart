import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/controllers/auth_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AuthController', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
    });

    test('signup and login flow', () async {
      final auth = AuthController();
      final ok = await auth.signup('Test User', 'test@example.com', 'password');
      expect(ok, isTrue);
      expect(auth.isAuthenticated, isTrue);
      expect(auth.user!.email, 'test@example.com');

      auth.logout();
      expect(auth.isAuthenticated, isFalse);

      final logged = await auth.login('test@example.com', 'password');
      expect(logged, isTrue);
      expect(auth.isAuthenticated, isTrue);
    });
  });
}
