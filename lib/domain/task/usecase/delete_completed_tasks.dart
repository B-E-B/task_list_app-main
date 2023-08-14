import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_application_tasks/domain/entity/entity.dart';
import 'package:flutter_application_tasks/domain/task/repository/task_repository.dart';

@singleton
class DeleteCompletedTasksUseCase {
  final TaskRepository _taskRepository;

  DeleteCompletedTasksUseCase(this._taskRepository);

  Future<Either<Failure, Success>> call() async {
    try {
      await _taskRepository.deleteCompletedTasks();
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
