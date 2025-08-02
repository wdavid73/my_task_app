import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_tasks_app/core/app.dart';
import 'package:my_tasks_app/core/di/injection.dart';
import 'package:my_tasks_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
