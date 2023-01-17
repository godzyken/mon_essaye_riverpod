import 'package:mockito/mockito.dart';
import 'package:mon_essaye_riverpod/src/features/authentication/data/auth_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class Listener<T> extends Mock {
  void call(T? previous, T? next);
}
