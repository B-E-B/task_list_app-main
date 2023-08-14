import 'package:injectable/injectable.dart';

import 'package:flutter_application_tasks/data/task/datasource/task_datasource.dart';
import 'package:flutter_application_tasks/domain/task/entity/task.dart';
import 'package:flutter_application_tasks/domain/task/mapper/task_mapper.dart';
import 'package:flutter_application_tasks/domain/task/repository/task_repository.dart';

@Singleton(as: TaskRepository)
class TaskRepositoryImpl extends TaskRepository with TaskMapper {
  final TaskDataSource _taskDataSource;

  TaskRepositoryImpl(this._taskDataSource);

  @override
  Stream<List<TaskEntity>> watchTasks() {
    return _taskDataSource.watchTasks().map(
          (tasks) => tasks
              .map(
                (e) => mapDbToEntityTask(e),
              )
              .toList(),
        );
  }

  @override
  Future<void> addTask(TaskEntity task) async {
    await _taskDataSource.addTask(mapEntityToDbTask(task));
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    await _taskDataSource.updateTask(mapEntityToDbTask(task));
  }

  @override
  Future<void> deleteTask(String id) async {
    await _taskDataSource.deleteTask(id);
  }

  @override
  Future<void> deleteCompletedTasks() async {
    await _taskDataSource.deleteCompletedTasks();
  }

  @override
  Future<void> deleteAllTasks() async {
    await _taskDataSource.deleteAllTasks();
  }

  @override
  Future<void> changeTaskStatus(TaskEntity task) async {
    await _taskDataSource.changeTaskStatus(mapEntityToDbTask(task));
  }
}
