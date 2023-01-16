import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../authentication/data/auth_repository.dart';
import '../../../data/repository/firestore_repository.dart';
import '../../../domain/entry.dart';

class JobsEntriesListController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // ok to leave this empty if the return type is FutureOr<void>
  }

  Future<void> deleteEntry(Entry entry) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    final database = ref.read(databaseProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => database.deleteEntry(uid: currentUser.uid, entry: entry));
  }
}

final jobsEntriesListControllerProvider =
    AutoDisposeAsyncNotifierProvider<JobsEntriesListController, void>(
        JobsEntriesListController.new);
