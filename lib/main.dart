import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'firebase_options.dart';
import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

final firebaseInitProvider = FutureProvider<FirebaseApp>((ref) async {
  String? name = 'mon_essaye_riverpod';
  return await Firebase.initializeApp(
    name: name,
    options: DefaultFirebaseOptions.currentPlatform,
  );
});
