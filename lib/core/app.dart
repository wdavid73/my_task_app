import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_tasks_app/application/blocs/auth/auth_bloc.dart';
import 'package:my_tasks_app/config/router/app_router.dart';
import 'package:my_tasks_app/config/theme/app_theme.dart';
import 'package:my_tasks_app/core/di/injection.dart';

/// The [GoRouter] instance used for navigation.
GoRouter? _router;

final _authBloc = getIt<AuthBloc>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    _router ??= createAppRouter(_authBloc);

    return MaterialApp.router(
      title: 'My Task App',
      themeMode: ThemeMode.system,
      theme: AppTheme.getLightTheme(context),
      darkTheme: AppTheme.getDarkTheme(context),
      routerConfig: _router,
    );
  }
}
