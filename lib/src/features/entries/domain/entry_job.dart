import '../../jobs/domain/entry.dart';
import '../../jobs/domain/job.dart';

class EntryJob {
  EntryJob(this.entry, this.job);

  final Entry entry;
  final Job job;
}
