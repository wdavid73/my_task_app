import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_tasks_app/application/blocs/tasks/tasks_bloc.dart';
import 'package:my_tasks_app/config/theme/theme.dart';
import 'package:my_tasks_app/core/di/injection.dart';
import 'package:my_tasks_app/ui/home/widgets/task_list.dart';
import 'package:my_tasks_app/ui/widgets/adaptive_scaffold.dart';
import 'package:my_tasks_app/ui/widgets/custom_button.dart';
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

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      scaffoldBackgroundColor: ColorTheme.navigationBackgroundColorLight,
      appBar: AppBar(title: Text(widget.title)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/task/new').then((_) => _refreshList()),
        tooltip: 'Add new task',
        child: const Icon(Icons.add),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [Expanded(child: TaskList())],
      ),
    );
  }
}
