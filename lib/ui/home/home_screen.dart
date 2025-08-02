import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_tasks_app/config/theme/theme.dart';
import 'package:my_tasks_app/ui/home/widgets/task_list.dart';
import 'package:my_tasks_app/ui/widgets/adaptive_scaffold.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      scaffoldBackgroundColor: ColorTheme.navigationBackgroundColorLight,
      appBar: AppBar(title: Text(widget.title)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/task/new'),
        tooltip: 'Add new task',
        child: const Icon(Icons.add),
      ),
      child: const Center(child: TaskList()),
    );
  }
}
