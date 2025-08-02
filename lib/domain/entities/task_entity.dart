enum TaskStatus { pending, complete }

class TaskEntity {
  final String title;
  final String description;
  final DateTime date;
  final List<String> tags;
  final TaskStatus status;

  TaskEntity({
    required this.date,
    required this.description,
    required this.title,
    this.tags = const [],
    this.status = TaskStatus.pending,
  }) : super();
}
