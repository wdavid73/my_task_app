import 'package:flutter/material.dart';
import 'package:my_tasks_app/core/app.dart';
import 'package:my_tasks_app/core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}
