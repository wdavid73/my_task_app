part of 'tasks_bloc.dart';

enum CreateStatus { none, success, error }

class TaskState extends Equatable {
  final List<TaskModel> tasks;
  final bool isLoading;
  final CreateStatus createStatus;
  final String error;
  final TaskFilter filter;

  const TaskState({
    this.tasks = const [],
    this.isLoading = false,
    this.createStatus = CreateStatus.none,
    this.error = '',
    this.filter = TaskFilter.none,
  });

  @override
  List<Object> get props => [tasks, isLoading, createStatus, error, filter];

  TaskState copyWith({
    List<TaskModel>? tasks,
    bool? isLoading,
    CreateStatus? createStatus,
    String? error,
    TaskFilter? filter,
  }) => TaskState(
    tasks: tasks ?? this.tasks,
    isLoading: isLoading ?? this.isLoading,
    createStatus: createStatus ?? this.createStatus,
    error: error ?? this.error,
    filter: filter ?? this.filter,
  );
}
