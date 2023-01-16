import 'package:mon_essaye_riverpod/src/features/authentication/domain/models/app_user.dart';

class FakeUser extends AppUser {
  final String name;
  final String password;

  FakeUser(
      {required super.uid,
      required super.email,
      required this.name,
      required this.password});
}
