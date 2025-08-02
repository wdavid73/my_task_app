import 'package:go_router/go_router.dart';
import 'package:my_tasks_app/application/blocs/auth/auth_bloc.dart';
import 'package:my_tasks_app/config/router/go_router_notifier.dart';
import 'package:my_tasks_app/config/router/redirect_handler.dart';
import 'package:my_tasks_app/config/router/routes_constants.dart';
import 'package:my_tasks_app/config/router/routes_generator.dart';

GoRouter createAppRouter(AuthBloc authBloc) {
  final goRouterNotifier = GoRouterNotifier(authBloc);

  return GoRouter(
    initialLocation: RouteConstants.splash,
    routes: AppRoutes.getAppRoutes(),
    refreshListenable: goRouterNotifier,
    redirect: (context, state) {
      return appRedirect(goRouterNotifier: goRouterNotifier, state: state);
    },
  );
}
