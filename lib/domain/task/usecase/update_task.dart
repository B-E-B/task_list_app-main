import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_application_tasks/domain/entity/entity.dart';
import 'package:flutter_application_tasks/domain/task/entity/task.dart';
import 'package:flutter_application_tasks/domain/task/repository/task_repository.dart';

@singleton
class UpdateTaskUseCase {
  final TaskRepository _taskRepository;

  UpdateTaskUseCase(this._taskRepository);

  Future<Either<Failure, Success>> call(TaskEntity task) async {
    try {
      await _taskRepository.updateTask(task);
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
