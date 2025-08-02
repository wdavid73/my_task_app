import 'package:injectable/injectable.dart';
import 'package:my_tasks_app/data/models/task_model.dart';
import 'package:my_tasks_app/domain/repositories/task_repository.dart';
import 'package:my_tasks_app/utils/task_filter.dart';

@lazySingleton
class TaskUsecase {
  final TaskRepository repository;

  TaskUsecase(this.repository);

  Future<List<TaskModel>> fetchTasks({
    TaskFilter filter = TaskFilter.none,
  }) async {
    return repository.getTasks(filter: filter);
  }

  Future<void> createTask(TaskModel task) async {
    return repository.addTask(task);
  }

  Future<void> deleteTask(int index) async {
    return repository.deleteTask(index);
  }

  Future<void> promoteTask(int index) async {
    return repository.promoteTask(index);
  }
}
