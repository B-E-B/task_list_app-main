import 'package:flutter_application_tasks/domain/task/entity/task.dart';

abstract class TaskRepository {
  Stream<List<TaskEntity>> watchTasks();
  Future<void> addTask(TaskEntity task);
  Future<void> updateTask(TaskEntity task);
  Future<void> deleteTask(String id);
  Future<void> deleteCompletedTasks();
  Future<void> deleteAllTasks();
  Future<void> changeTaskStatus(TaskEntity task);
}
