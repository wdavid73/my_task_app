import 'package:injectable/injectable.dart';
import 'package:my_tasks_app/data/datasources/in_memory_task_datasource.dart';
import 'package:my_tasks_app/data/models/task_model.dart';
import 'package:my_tasks_app/domain/repositories/task_repository.dart';
import 'package:my_tasks_app/utils/task_filter.dart';

@LazySingleton(as: TaskRepository)
class TaskRepositoryImpl implements TaskRepository {
  final TaskDataSource dataSource;

  TaskRepositoryImpl(this.dataSource);

  @override
  Future<void> addTask(TaskModel task) async {
    return dataSource.addTask(task);
  }

  @override
  Future<void> deleteTask(int id) async {
    return dataSource.deleteTask(id);
  }

  @override
  Future<void> promoteTask(int id) async {
    return dataSource.promoteTask(id);
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    return dataSource.updateTask(task);
  }

  @override
  Future<List<TaskModel>> getTasks({TaskFilter filter = TaskFilter.none}) {
    return dataSource.getTasks(filter: filter);
  }
}
