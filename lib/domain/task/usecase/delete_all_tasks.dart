import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_application_tasks/domain/entity/entity.dart';
import 'package:flutter_application_tasks/domain/task/repository/task_repository.dart';

@singleton
class DeleteAllTasksUseCase {
  final TaskRepository _taskRepository;

  DeleteAllTasksUseCase(this._taskRepository);

  Future<Either<Failure, Success>> call() async {
    try {
      await _taskRepository.deleteAllTasks();
      return Right(Success(message: 'OK'));
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
