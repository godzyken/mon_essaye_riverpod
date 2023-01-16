import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mon_essaye_riverpod/src/utils/async_value_ui.dart';

import '../../../../../common_widgets/list_items_builder.dart';
import '../../../../../routing/app_router.dart';
import '../../../data/repository/firestore_repository.dart';
import '../../../domain/entry.dart';
import '../../../domain/job.dart';
import '../controller/job_entries_list_controller.dart';
import 'entry_list_item.dart';

class JobEntriesList extends ConsumerWidget {
  const JobEntriesList({super.key, required this.job});
  final Job job;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      jobsEntriesListControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final entriesStream = ref.watch(jobEntriesStreamProvider(job));
    return ListItemsBuilder<Entry>(
      data: entriesStream,
      itemBuilder: (context, entry) {
        return DismissibleEntryListItem(
          dismissibleKey: Key('entry-${entry.id}'),
          entry: entry,
          job: job,
          onDismissed: () => ref
              .read(jobsEntriesListControllerProvider.notifier)
              .deleteEntry(entry),
          onTap: () => context.goNamed(
            AppRoute.entry.name,
            params: {'id': job.id, 'eid': entry.id},
            extra: entry,
          ),
        );
      },
    );
  }
}
