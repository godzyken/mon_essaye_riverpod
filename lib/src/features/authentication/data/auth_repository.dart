import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mon_essaye_riverpod/src/features/authentication/data/interface_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  AuthRepository(this._auth);
  final FirebaseAuth _auth;

  @override
  Stream<User?> authStateChanges() => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  @override
  Future<void> signInAnonymously() {
    return _auth.signInAnonymously();
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> createUserWithEmailAndPassword(String email, String password) {
    return _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> signOut() {
    return _auth.signOut();
  }
}

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(firebaseAuthProvider));
});

final authStateChangesProvider = StreamProvider.autoDispose<User?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});
