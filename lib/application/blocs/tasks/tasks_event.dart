part of 'tasks_bloc.dart';

abstract class TaskEvent {}

class GetTasksEvent extends TaskEvent {}

class CreateTasksEvent extends TaskEvent {
  final TaskModel task;

  CreateTasksEvent({required this.task});
}

class DeleteTaskEvent extends TaskEvent {
  final int index;
  DeleteTaskEvent({required this.index});
}

class PromoteToCompleteTaskEvent extends TaskEvent {
  final int index;
  PromoteToCompleteTaskEvent({required this.index});
}

class FilterTask extends TaskEvent {
  final TaskFilter filter;
  FilterTask({this.filter = TaskFilter.none});
}
