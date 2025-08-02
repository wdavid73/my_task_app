import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_tasks_app/application/blocs/auth/auth_bloc.dart';
import 'package:my_tasks_app/application/blocs/tasks/tasks_bloc.dart';
import 'package:my_tasks_app/config/theme/theme.dart';
import 'package:my_tasks_app/core/di/injection.dart';
import 'package:my_tasks_app/ui/home/widgets/task_list.dart';

import 'package:my_tasks_app/ui/widgets/adaptive_scaffold.dart';
import 'package:my_tasks_app/ui/widgets/custom_snack_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _refreshList() {
    getIt.get<TaskBloc>().getTask();
    CustomSnackBar.showSnackBar(
      context,
      message: 'Tarea agrega!',
      icon: Icons.celebration,
    );
  }

  void _logout() {
    final authBloc = getIt.get<AuthBloc>();
    authBloc.logout();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = getIt.get<AuthBloc>().state;
    return AdaptiveScaffold(
      scaffoldBackgroundColor: ColorTheme.navigationBackgroundColorLight,
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
        onPressed: () => context.push('/task/new').then((_) => _refreshList()),
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
          const Expanded(child: TaskList()),
        ],
      ),
    );
  }
}
