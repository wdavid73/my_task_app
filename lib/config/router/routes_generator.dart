import 'package:go_router/go_router.dart';
import 'package:my_tasks_app/ui/home/home_screen.dart';
import 'package:my_tasks_app/ui/task/task_screen.dart';

class AppRoutes {
  static List<RouteBase> getAppRoutes() {
    return [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (_, __) => const MyHomePage(title: 'My Home Page'),
      ),

      GoRoute(
        path: '/task/:id',
        name: 'task',
        builder: (context, state) =>
            TaskScreen(taskId: state.pathParameters['id'] ?? 'no-id'),
      ),
    ];
  }
}
