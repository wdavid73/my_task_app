import 'package:flutter/material.dart';
import 'package:my_tasks_app/config/router/app_router.dart';
import 'package:my_tasks_app/config/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My Task App',
      themeMode: ThemeMode.system,
      theme: AppTheme.getLightTheme(context),
      darkTheme: AppTheme.getDarkTheme(context),
      routerConfig: createAppRouter(),
    );
  }
}
