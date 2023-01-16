import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRepository {
  Stream<User?> authStateChanges();
  Future<void> signInAnonymously();
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}
