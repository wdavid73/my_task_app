import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_tasks_app/data/models/task_model.dart';
import 'package:my_tasks_app/domain/usecases/task_usecase.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

@lazySingleton
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskUsecase useCase;
  TaskBloc(this.useCase) : super(const TaskState()) {
    on<GetTasksEvent>((event, emit) async {
      try {
        emit(state.copyWith(isLoading: true));
        final response = await useCase.fetchTasks();
        emit(state.copyWith(tasks: response, isLoading: false));
      } catch (e) {
        emit(state.copyWith(tasks: [], isLoading: false));
      }
    });

    on<CreateTasksEvent>((event, emit) async {
      try {
        emit(state.copyWith(createStatus: CreateStatus.none, error: ''));
        await useCase.createTask(event.task);
        emit(state.copyWith(createStatus: CreateStatus.success));
      } catch (e) {
        emit(
          state.copyWith(createStatus: CreateStatus.error, error: e.toString()),
        );
      }
    });

    on<DeleteTaskEvent>((event, emit) async {
      try {
        emit(state.copyWith(isLoading: true));
        await useCase.deleteTask(event.index);
        final response = await useCase.fetchTasks();
        emit(state.copyWith(tasks: response, isLoading: false));
      } catch (e) {
        debugPrint('error: $e');
        emit(state);
      }
    });

    on<PromoteToCompleteTaskEvent>((event, emit) async {
      try {
        emit(state.copyWith(isLoading: true));
        await useCase.promoteTask(event.index);
        final response = await useCase.fetchTasks();
        emit(state.copyWith(tasks: response, isLoading: false));
      } catch (e) {
        debugPrint('error: $e');
        emit(state);
      }
    });
  }
  void getTask() {
    add(GetTasksEvent());
  }

  void createTasks(TaskModel task) {
    add(CreateTasksEvent(task: task));
  }

  void deleteTask(int index) {
    add(DeleteTaskEvent(index: index));
  }

  void promoteTask(int index) {
    add(PromoteToCompleteTaskEvent(index: index));
  }
}
