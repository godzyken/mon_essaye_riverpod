import 'package:flutter/cupertino.dart';
import 'package:mon_essaye_riverpod/src/features/authentication/domain/models/fake_user.dart';

class UserListItem extends StatelessWidget {
  final FakeUser fakeUser;

  const UserListItem({super.key, required this.fakeUser});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(fakeUser.name);
  }
}
