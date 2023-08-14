import 'package:flutter_application_tasks/data/database/app_db.dart';

abstract class TaskDataSource {
  Stream<List<Task>> watchTasks();
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(String id);
  Future<void> deleteCompletedTasks();
  Future<void> deleteAllTasks();
  Future<void> changeTaskStatus(Task task);
}
