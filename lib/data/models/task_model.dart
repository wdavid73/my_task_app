import 'package:my_tasks_app/data/mappers/task_mapper.dart';
import 'package:my_tasks_app/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required super.title,
    required super.date,
    required super.description,
    super.status,
    super.tags,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      TaskMapper.taskJsonToModel(json);

  TaskModel copyWith({
    String? title,
    String? description,
    DateTime? date,
    TaskStatus? status,
    List<String>? tags,
  }) => TaskModel(
    title: title ?? this.title,
    date: date ?? this.date,
    description: description ?? this.description,
    status: status ?? this.status,
    tags: tags ?? this.tags,
  );
}
