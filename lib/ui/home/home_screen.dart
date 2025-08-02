import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_tasks_app/application/blocs/auth/auth_bloc.dart';
import 'package:my_tasks_app/application/blocs/tasks/tasks_bloc.dart';
import 'package:my_tasks_app/config/theme/theme.dart';
import 'package:my_tasks_app/core/di/injection.dart';
import 'package:my_tasks_app/ui/home/widgets/task_list.dart';

import 'package:my_tasks_app/ui/widgets/adaptive_scaffold.dart';
import 'package:my_tasks_app/ui/widgets/custom_snack_bar.dart';
import 'package:my_tasks_app/utils/task_filter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _refreshList(dynamic value) {
    getIt.get<TaskBloc>().getTask();

    if (value == true) {
      CustomSnackBar.showSnackBar(
        context,
        message: 'Tarea agrega!',
        icon: Icons.celebration,
        duration: const Duration(seconds: 3),
      );
    }
  }

  void _logout() {
    final authBloc = getIt.get<AuthBloc>();
    authBloc.logout();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = getIt.get<AuthBloc>().state;
    return AdaptiveScaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () => _logout(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await context.push('/task/new');
          _refreshList(result);
        },
        tooltip: 'Add new task',
        child: const Icon(Icons.add),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Bienvenido: ${authBloc.user?.email}',
                style: context.textTheme.titleMedium,
              ),
            ),
          ),
          const _Filters(),
          const Expanded(child: TaskList()),
        ],
      ),
    );
  }
}

class _Filters extends StatelessWidget {
  const _Filters();

  void _filterList(TaskFilter filter) {
    final taskBloc = getIt.get<TaskBloc>();
    taskBloc.filterTasks(filter);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      bloc: getIt.get<TaskBloc>(),
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            spacing: 10,
            children: [
              FilterChip(
                label: const Text('Pendientes'),
                selected: state.filter == TaskFilter.pending,
                onSelected: (val) {
                  _filterList(val ? TaskFilter.pending : TaskFilter.none);
                },
              ),
              FilterChip(
                label: const Text('Completadas'),
                selected: state.filter == TaskFilter.complete,
                onSelected: (val) {
                  _filterList(val ? TaskFilter.complete : TaskFilter.none);
                },
                backgroundColor: ColorTheme.success,
              ),
            ],
          ),
        );
      },
    );
  }
}
