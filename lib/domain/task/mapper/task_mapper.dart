import 'package:flutter_application_tasks/data/database/app_db.dart' as db;
import 'package:flutter_application_tasks/domain/task/entity/task.dart' as entity;

mixin TaskMapper {
  entity.TaskEntity mapDbToEntityTask(db.Task task) {
    return entity.TaskEntity(
      id: task.id,
      name: task.name,
      isCompleted: task.isCompleted,
    );
  }

  db.Task mapEntityToDbTask(entity.TaskEntity task) {
    return db.Task(
      id: task.id,
      name: task.name,
      isCompleted: task.isCompleted,
    );
  }
}
