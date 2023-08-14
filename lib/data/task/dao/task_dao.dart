import 'package:drift/drift.dart';

import 'package:flutter_application_tasks/data/database/app_db.dart';
import 'package:flutter_application_tasks/data/task/table/tasks.dart';

part 'task_dao.g.dart';

@DriftAccessor(tables: [Tasks])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  TaskDao(AppDatabase db) : super(db);

  Stream<List<Task>> watchTasks() {
    return select(tasks).watch();
  }

  Future<int> addTask(Task newTask) async {
    return await into(tasks).insert(newTask);
  }

  Future<Future<bool>> updateTask(Task newTask) async {
    return update(tasks).replace(newTask);
  }

  Future<void> deleteTask(String id) async {
    await (delete(tasks)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> deleteCompletedTask() async {
    await (delete(tasks)..where((tbl) => tbl.isCompleted)).go();
  }

  Future<void> deleteAllTasks() async {
    await delete(tasks).go();
  }
}
