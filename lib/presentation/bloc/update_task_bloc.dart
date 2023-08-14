import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_application_tasks/domain/task/entity/task.dart';
import 'package:flutter_application_tasks/domain/task/usecase/update_task.dart';

@injectable
class UpdateTaskBloc {
  final TextEditingController controller;
  final String taskName;
  final UpdateTaskUseCase _updateTaskUseCase;

  String get task => controller.text.trim();

  UpdateTaskBloc(this._updateTaskUseCase,
      {@factoryParam required this.taskName})
      : controller = TextEditingController(text: taskName);

  Future<void> updateTask(TaskEntity task) async {
    await _updateTaskUseCase(
        task.copyWith(name: capitalizeFirstLetter(task.name)));
  }

  String capitalizeFirstLetter(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }
}
