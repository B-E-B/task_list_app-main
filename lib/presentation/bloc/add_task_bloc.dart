import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_application_tasks/domain/task/entity/task.dart';
import 'package:flutter_application_tasks/domain/task/usecase/add_task_usecase.dart';

@injectable
class AddTaskBloc {
  final TextEditingController controller;
  final AddTaskUseCase _addTaskUseCase;

  String get task => controller.text.trim();

  AddTaskBloc(this._addTaskUseCase) : controller = TextEditingController();

  Future<void> addTask(TaskEntity task) async {
    await _addTaskUseCase(
        task.copyWith(name: capitalizeFirstLetter(task.name)));
  }

  String capitalizeFirstLetter(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }
}
