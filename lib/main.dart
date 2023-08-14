import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_application_tasks/common/theme/app_themes.dart';
import 'package:flutter_application_tasks/data/database/app_db.dart';
import 'package:flutter_application_tasks/di/di.dart';
import 'package:flutter_application_tasks/presentation/screen/add_task_screen.dart';
import 'package:flutter_application_tasks/presentation/screen/task_list_screen.dart';
import 'package:flutter_application_tasks/presentation/screen/update_task_screen.dart';

void main() async {
  getIt.registerSingleton<AppDatabase>(AppDatabase(), signalsReady: true);

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  await configureDependencies(Environment.dev);

  runApp(const TasksApp());
}

class TasksApp extends StatelessWidget {
  const TasksApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Задачи',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      initialRoute: TaskListScreen.routeName,
      routes: {
        TaskListScreen.routeName: (context) => const TaskListScreen(),
        AddTaskScreen.routeName: (context) => const AddTaskScreen(),
        UpdateTaskScreen.routeName: (context) => const UpdateTaskScreen(),
      },
    );
  }
}
