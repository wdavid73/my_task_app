import 'package:go_router/go_router.dart';
import 'package:my_tasks_app/config/router/routes_constants.dart';
import 'package:my_tasks_app/ui/auth/login_screen.dart';
import 'package:my_tasks_app/ui/auth/register_screen.dart';
import 'package:my_tasks_app/ui/home/home_screen.dart';
import 'package:my_tasks_app/ui/screen/check_auth_status_screen.dart';
import 'package:my_tasks_app/ui/task/task_screen.dart';

class AppRoutes {
  static List<RouteBase> getAppRoutes() {
    return [
      GoRoute(
        path: RouteConstants.splash,
        name: 'splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),

      GoRoute(
        path: RouteConstants.home,
        name: 'home',
        builder: (_, __) => const MyHomePage(title: 'My Home Page'),
      ),

      GoRoute(
        path: RouteConstants.loginScreen,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),

      /// REGISTER ROUTE
      GoRoute(
        path: RouteConstants.registerScreen,
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),

      GoRoute(
        path: '/task/:id',
        name: 'task',
        builder: (context, state) =>
            TaskScreen(taskIndex: state.pathParameters['id'] ?? 'no-id'),
      ),
    ];
  }
}
