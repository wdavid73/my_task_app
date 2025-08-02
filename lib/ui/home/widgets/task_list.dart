import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_tasks_app/application/blocs/tasks/tasks_bloc.dart';
import 'package:my_tasks_app/config/theme/color_theme.dart';
import 'package:my_tasks_app/config/theme/utils/font_extension_theme.dart';
import 'package:my_tasks_app/config/theme/utils/responsive.dart';
import 'package:my_tasks_app/core/di/injection.dart';
import 'package:my_tasks_app/data/models/task_model.dart';
import 'package:my_tasks_app/domain/entities/task_entity.dart';
import 'package:my_tasks_app/ui/home/widgets/custom_popup_menu.dart';
import 'package:my_tasks_app/ui/shared/styles/app_spacing.dart';
import 'package:my_tasks_app/ui/widgets/custom_snack_bar.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    getIt.get<TaskBloc>().getTask();
  }

  void _promoteTaskToComplete(int index) {
    getIt.get<TaskBloc>().promoteTask(index);
    CustomSnackBar.showSnackBar(
      context,
      message: 'Tarea completada!',
      icon: Icons.check,
    );
  }

  void _deleteTask(int index) {
    getIt.get<TaskBloc>().deleteTask(index);
    CustomSnackBar.showSnackBar(
      context,
      message: 'Tarea eliminada!',
      icon: Icons.close,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      bloc: getIt.get<TaskBloc>(),
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        if (state.tasks.isEmpty) {
          return const Center(child: Text('No hay tareas creadas aun.'));
        }
        return ListView.builder(
          itemCount: state.tasks.length,
          itemBuilder: (context, index) {
            final TaskModel task = state.tasks[index];
            return FadeInRight(
              child: _TaskItem(
                task: task,
                onOptionSelected: (action) {
                  if (action == 'promote_to_complete') {
                    _promoteTaskToComplete(index);
                    return;
                  }

                  if (action == 'delete') {
                    _deleteTask(index);
                    return;
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}

class _TaskItem extends StatelessWidget {
  final void Function(String action) onOptionSelected;
  const _TaskItem({required this.task, required this.onOptionSelected});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 0,
            top: 8,
            bottom: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 10,
                        children: [
                          Text(
                            task.title,
                            style: context.textTheme.titleMedium,
                          ),
                          _TaskStatusChip(status: task.status),
                        ],
                      ),
                      AppSpacing.sm,
                      Text(
                        DateFormat.yMMMd().format(task.date),
                        style: context.textTheme.bodyMedium,
                      ),
                      if (task.description.isNotEmpty)
                        Text(
                          task.description,
                          style: context.textTheme.bodySmall,
                        ),
                    ],
                  ),
                  CustomPopupMenu(onTap: onOptionSelected, task: task),
                ],
              ),

              if (task.tags.isNotEmpty)
                SizedBox(
                  width: context.width,
                  height: 50,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: task.tags.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, j) {
                      final String tag = task.tags[j];
                      return Padding(
                        padding: const EdgeInsets.only(right: 2),
                        child: Chip(
                          label: Text(tag),
                          labelPadding: EdgeInsets.zero,
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TaskStatusChip extends StatelessWidget {
  final TaskStatus status;
  const _TaskStatusChip({this.status = TaskStatus.pending});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: status == TaskStatus.complete
            ? ColorTheme.success
            : ColorTheme.primaryColor,
        borderRadius: BorderRadius.circular(100),
      ),
      padding: const EdgeInsets.all(4),
      child: Text(
        status == TaskStatus.complete ? 'Completado' : 'Pendiente',
        style: context.textTheme.bodySmall?.copyWith(color: Colors.white),
      ),
    );
  }
}
