import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mon_essaye_riverpod/src/utils/async_value_ui.dart';

import '../../../../../common_widgets/list_items_builder.dart';
import '../../../../../constants/Strings.dart';
import '../../../../../routing/app_router.dart';
import '../../../data/repository/firestore_repository.dart';
import '../../../domain/job.dart';
import '../controller/jobs_screen_controller.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.jobs),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => context.goNamed(AppRoute.addJob.name),
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          ref.listen<AsyncValue>(
            jobsScreenControllerProvider,
            (_, state) => state.showAlertDialogOnError(context),
          );
          // * TODO: investigate why we get a dismissible error if we call
          // * ref.watch(jobsScreenControllerProvider) here
          final jobsAsyncValue = ref.watch(jobsStreamProvider);
          return ListItemsBuilder<Job>(
            data: jobsAsyncValue,
            itemBuilder: (context, job) => Dismissible(
              key: Key('job-${job.id}'),
              background: Container(color: Colors.red),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) => ref
                  .read(jobsScreenControllerProvider.notifier)
                  .deleteJob(job),
              child: JobListTile(
                job: job,
                onTap: () => context.goNamed(
                  AppRoute.job.name,
                  params: {'id': job.id},
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class JobListTile extends StatelessWidget {
  const JobListTile({Key? key, required this.job, this.onTap})
      : super(key: key);
  final Job job;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(job.name),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
