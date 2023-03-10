import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../authentication/data/auth_repository.dart';
import '../../../data/repository/firestore_repository.dart';
import '../../../domain/job.dart';
import '../views/job_submit_exception.dart';

class EditJobScreenController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // ok to leave this empty if the return type is FutureOr<void>
  }

  Future<bool> submit(
      {Job? job, required String name, required int ratePerHour}) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    // set loading state
    state = const AsyncLoading().copyWithPrevious(state);
    // check if name is already in use
    final database = ref.read(databaseProvider);
    final jobs = await database.fetchJobs(uid: currentUser.uid);
    final allLowerCaseNames =
        jobs.map((job) => job.name.toLowerCase()).toList();
    if (job != null) {
      allLowerCaseNames.remove(job.name.toLowerCase());
    }
    // check if name is already used
    if (allLowerCaseNames.contains(name.toLowerCase())) {
      state = AsyncError(JobSubmitException(), StackTrace.current);
      return false;
    } else {
      final id = job?.id ?? documentIdFromCurrentDate();
      final updated = Job(id: id, name: name, ratePerHour: ratePerHour);
      state = await AsyncValue.guard(
        () => database.setJob(uid: currentUser.uid, job: updated),
      );
      return state.hasError == false;
    }
  }
}

final editJobScreenControllerProvider =
    AutoDisposeAsyncNotifierProvider<EditJobScreenController, void>(
        EditJobScreenController.new);
