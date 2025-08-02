import 'package:injectable/injectable.dart';

import 'package:my_tasks_app/data/models/task_model.dart';
import 'package:my_tasks_app/domain/entities/task_entity.dart';
import 'package:my_tasks_app/utils/task_filter.dart';

abstract class TaskDataSource {
  Future<List<TaskModel>> getTasks({TaskFilter filter = TaskFilter.none});
  Future<void> addTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(int id);
  Future<void> promoteTask(int id);
}

List<TaskModel> tasksDefault = [
  TaskModel(
    title: 'Tarea completada',
    date: DateTime.now(),
    description: 'Descripción de prueba',
    status: TaskStatus.complete,
  ),
  TaskModel(
    title: 'Tarea pendiente',
    date: DateTime(2025, 02, 01),
    description: 'Descripción de prueba',
    status: TaskStatus.pending,
  ),
];

@LazySingleton(as: TaskDataSource)
class InMemoryTaskDataSource implements TaskDataSource {
  final List<TaskModel> _tasks = [...tasksDefault];

  @override
  Future<void> addTask(TaskModel task) async => _tasks.add(task);

  @override
  Future<void> deleteTask(int id) async {
    if (id >= 0 && id < _tasks.length) {
      _tasks.removeAt(id);
    }
  }

  @override
  Future<List<TaskModel>> getTasks({
    TaskFilter filter = TaskFilter.none,
  }) async {
    switch (filter) {
      case TaskFilter.complete:
        return _tasks.where((t) => t.status == TaskStatus.complete).toList();
      case TaskFilter.pending:
        return _tasks.where((t) => t.status == TaskStatus.pending).toList();
      case TaskFilter.none:
        return [..._tasks];
    }
  }

  @override
  Future<void> promoteTask(int id) async {
    if (id >= 0 && id < _tasks.length) {
      final task = _tasks[id];
      _tasks[id] = task.copyWith(status: TaskStatus.complete);
    }
  }

  @override
  Future<void> updateTask(TaskModel task) {
    throw UnimplementedError();
  }
}
