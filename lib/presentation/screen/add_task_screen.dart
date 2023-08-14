import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter_application_tasks/di/di.dart';
import 'package:flutter_application_tasks/domain/task/entity/task.dart';
import 'package:flutter_application_tasks/presentation/bloc/add_task_bloc.dart';
import 'package:flutter_application_tasks/presentation/widget/appbar/my_app_bar.dart';
import 'package:flutter_application_tasks/presentation/widget/button/my_elevated_button.dart';
import 'package:flutter_application_tasks/presentation/widget/textfield/my_text_field.dart';

class AddTaskScreen extends StatelessWidget {
  static const routeName = '/addTask';

  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AddTaskBloc>(
          create: (_) => getIt<AddTaskBloc>(),
        )
      ],
      child: Consumer<AddTaskBloc>(
        builder: (context, AddTaskBloc addTaskBloc, _) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: _buildBody(context, addTaskBloc),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return const MyAppBar(
      title: 'Добавление задачи',
    );
  }

  Widget _buildBody(BuildContext context, AddTaskBloc addTaskBloc) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MyTextField(bloc: addTaskBloc, label: 'Новая задача'),
          const SizedBox(height: 20),
          MyElevatedButton(
            title: 'Добавить',
            onPressed: () async =>
                await _onAddTaskButtonTapped(context, addTaskBloc),
          ),
        ],
      ),
    );
  }

  Future<void> _onAddTaskButtonTapped(
    BuildContext context,
    AddTaskBloc addTaskBloc,
  ) async {
    if (addTaskBloc.task.isNotEmpty) {
      final String taskId = const Uuid().v4();

      addTaskBloc.addTask(TaskEntity(
        id: taskId,
        name: addTaskBloc.task,
        isCompleted: false,
      ));

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Задача успешно добавлена!',
            textAlign: TextAlign.center,
          ),
          duration: Duration(milliseconds: 1000),
        ),
      );
    }
  }
}
