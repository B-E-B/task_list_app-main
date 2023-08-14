import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:flutter_application_tasks/domain/task/entity/task.dart';
import 'package:flutter_application_tasks/domain/task/usecase/change_task_status.dart';
import 'package:flutter_application_tasks/domain/task/usecase/delete_all_tasks.dart';
import 'package:flutter_application_tasks/domain/task/usecase/delete_completed_tasks.dart';
import 'package:flutter_application_tasks/domain/task/usecase/delete_task_usecase.dart';
import 'package:flutter_application_tasks/domain/task/usecase/watch_tasks_usecase.dart';

@injectable
class TaskListBloc {
  final WatchTasksUseCase _watchTasksUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;
  final DeleteCompletedTasksUseCase _deleteCompletedTasksUseCase;
  final DeleteAllTasksUseCase _deleteAllTasksUseCase;
  final ChangeTaskStatusUseCase _changeTaskStatusUseCase;

  final BehaviorSubject<List<TaskEntity>> _tasksController =
      BehaviorSubject.seeded([]);

  final BehaviorSubject<bool> _collapseFlag = BehaviorSubject.seeded(false);

  StreamSubscription<List<TaskEntity>>? _taskSubscription;

  Stream<List<TaskEntity>> get tasksStream => _tasksController.stream;

  Stream<bool> get collapseFlagStream => _collapseFlag.stream;

  List<TaskEntity> get incompleteTasks =>
      _tasksController.value.where((task) => !task.isCompleted).toList();

  List<TaskEntity> get completedTasks =>
      _tasksController.value.where((task) => task.isCompleted).toList();
      
  TaskListBloc(
      this._watchTasksUseCase,
      this._deleteTaskUseCase,
      this._deleteCompletedTasksUseCase,
      this._deleteAllTasksUseCase,
      this._changeTaskStatusUseCase) {
    _watchTasks();
  }

  Future<void> _watchTasks() async {
    _watchTasksUseCase().fold((failure) {
      if (kDebugMode) {
        print(failure.message);
      }
    }, (taskStream) {
      _taskSubscription?.cancel();
      _taskSubscription = taskStream.listen((tasks) {
        _tasksController.add(tasks);
      });
    });
  }

  Future<void> deleteTask(String id) async {
    await _deleteTaskUseCase(id);
  }

  Future<void> deleteCompletedTasks() async {
    _collapseFlag.add(false);
    await _deleteCompletedTasksUseCase();
  }

  Future<void> deleteAllTasks() async {
    _collapseFlag.add(false);
    await _deleteAllTasksUseCase();
  }

  Future<void> changeTaskStatus(TaskEntity task) async {
    await _changeTaskStatusUseCase(task);
  }

  Future<void> changeCollapseStatus() async {
    _collapseFlag.add(!_collapseFlag.value);
  }

  dispose() {
    _tasksController.close();
    _taskSubscription?.cancel();
  }
}
