import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../common_widgets/async_value_widget.dart';
import '../../../../../routing/app_router.dart';
import '../../../data/repository/firestore_repository.dart';
import '../../../domain/job.dart';
import 'job_entries_list.dart';

class JobEntriesScreen extends ConsumerWidget {
  const JobEntriesScreen({super.key, required this.jobId});
  final JobID jobId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobAsync = ref.watch(jobStreamProvider(jobId));
    return ScaffoldAsyncValueWidget<Job>(
      value: jobAsync,
      data: (job) => JobEntriesPageContents(job: job),
    );
  }
}

class JobEntriesPageContents extends StatelessWidget {
  const JobEntriesPageContents({super.key, required this.job});
  final Job job;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(job.name),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () => context.goNamed(
              AppRoute.editJob.name,
              params: {'id': job.id},
              extra: job,
            ),
          ),
        ],
      ),
      body: JobEntriesList(job: job),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => context.goNamed(
          AppRoute.addEntry.name,
          params: {'id': job.id},
          extra: job,
        ),
      ),
    );
  }
}
