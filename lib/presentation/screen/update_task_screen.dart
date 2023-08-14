import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_tasks/di/di.dart';
import 'package:flutter_application_tasks/domain/task/entity/task.dart';
import 'package:flutter_application_tasks/presentation/bloc/update_task_bloc.dart';
import 'package:flutter_application_tasks/presentation/widget/appbar/my_app_bar.dart';
import 'package:flutter_application_tasks/presentation/widget/button/my_elevated_button.dart';
import 'package:flutter_application_tasks/presentation/widget/textfield/my_text_field.dart';

class UpdateTaskScreen extends StatelessWidget {
  static const routeName = '/updateTask';

  const UpdateTaskScreen({Key? key, TaskEntity? lastTask}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lastTask = ModalRoute.of(context)?.settings.arguments;

    if (lastTask is! TaskEntity) {
      return const SizedBox.shrink();
    }

    return MultiProvider(
      providers: [
        Provider<UpdateTaskBloc>(
          create: (_) => getIt<UpdateTaskBloc>(param1: lastTask.name),
        ),
      ],
      child: Consumer<UpdateTaskBloc>(
        builder: (context, updateTaskBloc, _) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: _buildBody(context, updateTaskBloc, lastTask),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return const MyAppBar(
      title: 'Редактирование задачи',
    );
  }

  Widget _buildBody(BuildContext context, UpdateTaskBloc updateTaskBloc,
      TaskEntity lastTask) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyTextField(bloc: updateTaskBloc, label: 'Задача'),
          const SizedBox(height: 16),
          MyElevatedButton(
              title: 'Сохранить',
              onPressed: () async {
                await _onSaveTaskButtonTapped(
                    context, updateTaskBloc, lastTask);
              }),
        ],
      ),
    );
  }

  Future<void> _onSaveTaskButtonTapped(
    BuildContext context,
    UpdateTaskBloc updateTaskBloc,
    TaskEntity lastTask,
  ) async {
    if (updateTaskBloc.task.isNotEmpty &&
        lastTask.name != updateTaskBloc.task) {
      updateTaskBloc.updateTask(lastTask.copyWith(name: updateTaskBloc.task));

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Задача успешно отредактирована!',
            textAlign: TextAlign.center,
          ),
          duration: Duration(milliseconds: 1000)));
    }
    Navigator.pop(context);
  }
}
