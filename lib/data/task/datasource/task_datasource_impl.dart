import 'package:injectable/injectable.dart';

import 'package:flutter_application_tasks/data/database/app_db.dart';
import 'package:flutter_application_tasks/data/task/datasource/task_datasource.dart';

@Singleton(as: TaskDataSource)
class TaskDataSourceImpl extends TaskDataSource {
  final AppDatabase _dataBase;

  TaskDataSourceImpl(
    this._dataBase,
  );
  @override
  Stream<List<Task>> watchTasks() {
    return _dataBase.taskDao.watchTasks();
  }

  @override
  Future<void> addTask(Task task) async {
    await _dataBase.taskDao.addTask(task);
  }

  @override
  Future<void> updateTask(Task task) async {
    await _dataBase.taskDao.updateTask(task);
  }

  @override
  Future<void> deleteTask(String id) async {
    await _dataBase.taskDao.deleteTask(id);
  }

  @override
  Future<void> deleteCompletedTasks() async {
    await _dataBase.taskDao.deleteCompletedTask();
  }

  @override
  Future<void> deleteAllTasks() async {
    await _dataBase.taskDao.deleteAllTasks();
  }

  @override
  Future<void> changeTaskStatus(Task task) async {
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
    await updateTask(updatedTask);
  }
}
