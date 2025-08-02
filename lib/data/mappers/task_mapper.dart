import 'package:my_tasks_app/data/models/task_model.dart';
import 'package:my_tasks_app/domain/entities/task_entity.dart';

class TaskMapper {
  static TaskModel taskJsonToModel(Map<String, dynamic> json) => TaskModel(
    title: json['title'],
    date: json['date'] ?? DateTime.now(),
    description: json['description'] ?? '',
    tags: json['tags'],
    status: json['status'] ?? TaskStatus.pending,
  );
}
