import 'package:go_router/go_router.dart';
import 'package:my_tasks_app/config/router/routes_generator.dart';

GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: '/task/new',
    routes: AppRoutes.getAppRoutes(),
  );
}
