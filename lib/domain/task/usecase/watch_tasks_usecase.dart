import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_application_tasks/domain/entity/entity.dart';
import 'package:flutter_application_tasks/domain/task/entity/task.dart';
import 'package:flutter_application_tasks/domain/task/repository/task_repository.dart';

@singleton
class WatchTasksUseCase {
  final TaskRepository _taskRepository;

  WatchTasksUseCase(this._taskRepository);

  Either<Failure, Stream<List<TaskEntity>>> call() {
    try {
      return Right(_taskRepository.watchTasks());
    } catch (e, s) {
      return Left(
        Failure(
          exception: e,
          stackTrace: s,
          message: e.toString(),
        ),
      );
    }
  }
}
