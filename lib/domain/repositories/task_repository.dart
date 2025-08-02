import 'package:my_tasks_app/data/models/task_model.dart';
import 'package:my_tasks_app/utils/task_filter.dart';

abstract class TaskRepository {
  Future<List<TaskModel>> getTasks({TaskFilter filter = TaskFilter.none});
  Future<void> addTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(int id);
  Future<void> promoteTask(int id);
}
