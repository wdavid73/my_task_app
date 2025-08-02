import 'package:injectable/injectable.dart';
import 'package:my_tasks_app/data/models/task_model.dart';
import 'package:my_tasks_app/domain/entities/task_entity.dart';

abstract class TaskDataSource {
  Future<List<TaskModel>> getTasks();
  Future<void> addTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(int id);
  Future<void> promoteTask(int id);
}

@LazySingleton(as: TaskDataSource)
class InMemoryTaskDataSource implements TaskDataSource {
  final List<TaskModel> _tasks = [];

  @override
  Future<void> addTask(TaskModel task) async => _tasks.add(task);

  @override
  Future<void> deleteTask(int id) async {
    if (id >= 0 && id < _tasks.length) {
      _tasks.removeAt(id);
    }
  }

  @override
  Future<List<TaskModel>> getTasks() async => [..._tasks];

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
