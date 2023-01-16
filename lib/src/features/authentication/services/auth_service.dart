import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/auth_repository.dart';

class AuthService {
  AuthService({required this.database});
  final AuthRepository database;

  Stream<User?> get authStateChange => database.authStateChanges();

  //  SigIn the user using Email and Password
  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await database.signInWithEmailAndPassword(email, password);
    } on FirebaseAuthException catch (code, message) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('FirebaseAuthException login code: $code'),
                content: Text(message.toString()),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text("OK")),
                ],
              ));
    }
  }

  //  SignUp the user using Email and Password
  Future<void> signUpWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await database.createUserWithEmailAndPassword(email, password);
    } on FirebaseAuthException catch (code, message) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('FirebaseAuthException register code: $code'),
                content: Text(message.toString()),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text("OK")),
                ],
              ));
    }
  }

  //  SignOut current user
  Future<void> signOut() async {
    await database.signOut();
  }
}

final databaseProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(firebaseAuthProvider));
});

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(database: ref.watch(databaseProvider));
});
