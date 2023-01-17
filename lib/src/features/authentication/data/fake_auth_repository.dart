import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/in_memory_store.dart';
import '../domain/models/app_user.dart';
import '../domain/models/fake_user.dart';

class FakeAuthRepository {
  final _authState = InMemoryStore<AppUser?>(null);

  FirebaseAuth get _auth => throw UnimplementedError();

  Stream<AppUser?> authStateChanges() => _authState.stream;

  Future<void> createUserWithEmailAndPassword(String email, String password) {
    // TODO: implement createUserWithEmailAndPassword
    throw UnimplementedError();
  }

  AppUser? get currentUser => _authState.value;

  Future<void> signInAnonymously() async {
    await Future.delayed(const Duration(seconds: 3));
    _authState.value = const AppUser(uid: '321', email: 'isgodzy@gmail.com');
  }

  Future<void> signInWithEmailAndPassword(String email, String password) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  Future<void> signOut() async {
    _authState.value = null;
  }

  Future<List<FakeUser>> fetchUsers() async {
    return [
      FakeUser(
          uid: '23',
          email: 'isgodzy@gmail.com',
          name: 'goki',
          password: 'password')
    ];
  }

  Future<void> useAuthEmulator(String host, int port) async {
    return await _auth.useAuthEmulator(host, port);
  }

  void dispose() => _authState.close();
}

final authRepositoryProvider = Provider<FakeAuthRepository>((ref) {
  final auth = FakeAuthRepository();
  ref.onDispose(() => auth.dispose());
  return auth;
});

final authStateChangesProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});
final todoListProvider = FutureProvider((ref) async {
  final repository = ref.watch(authRepositoryProvider);
  return repository.fetchUsers();
});
