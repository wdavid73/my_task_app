import 'package:my_tasks_app/data/models/task_model.dart';

abstract class TaskRepository {
  Future<List<TaskModel>> getTasks();
  Future<void> addTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(int id);
  Future<void> promoteTask(int id);
}
