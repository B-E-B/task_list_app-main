// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/database/app_db.dart' as _i5;
import '../data/task/datasource/task_datasource.dart' as _i3;
import '../data/task/datasource/task_datasource_impl.dart' as _i4;
import '../domain/task/repository/task_repository.dart' as _i6;
import '../domain/task/repository/task_repository_impl.dart' as _i7;
import '../domain/task/usecase/add_task_usecase.dart' as _i10;
import '../domain/task/usecase/change_task_status.dart' as _i11;
import '../domain/task/usecase/delete_all_tasks.dart' as _i12;
import '../domain/task/usecase/delete_completed_tasks.dart' as _i13;
import '../domain/task/usecase/delete_task_usecase.dart' as _i14;
import '../domain/task/usecase/update_task.dart' as _i8;
import '../domain/task/usecase/watch_tasks_usecase.dart' as _i9;
import '../presentation/bloc/add_task_bloc.dart' as _i17;
import '../presentation/bloc/task_list_bloc.dart' as _i15;
import '../presentation/bloc/update_task_bloc.dart' as _i16;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.singleton<_i3.TaskDataSource>(
      _i4.TaskDataSourceImpl(gh<_i5.AppDatabase>()));
  gh.singleton<_i6.TaskRepository>(
      _i7.TaskRepositoryImpl(gh<_i3.TaskDataSource>()));
  gh.singleton<_i8.UpdateTaskUseCase>(
      _i8.UpdateTaskUseCase(gh<_i6.TaskRepository>()));
  gh.singleton<_i9.WatchTasksUseCase>(
      _i9.WatchTasksUseCase(gh<_i6.TaskRepository>()));
  gh.singleton<_i10.AddTaskUseCase>(
      _i10.AddTaskUseCase(gh<_i6.TaskRepository>()));
  gh.singleton<_i11.ChangeTaskStatusUseCase>(
      _i11.ChangeTaskStatusUseCase(gh<_i6.TaskRepository>()));
  gh.singleton<_i12.DeleteAllTasksUseCase>(
      _i12.DeleteAllTasksUseCase(gh<_i6.TaskRepository>()));
  gh.singleton<_i13.DeleteCompletedTasksUseCase>(
      _i13.DeleteCompletedTasksUseCase(gh<_i6.TaskRepository>()));
  gh.singleton<_i14.DeleteTaskUseCase>(
      _i14.DeleteTaskUseCase(gh<_i6.TaskRepository>()));
  gh.factory<_i15.TaskListBloc>(() => _i15.TaskListBloc(
        gh<_i9.WatchTasksUseCase>(),
        gh<_i14.DeleteTaskUseCase>(),
        gh<_i13.DeleteCompletedTasksUseCase>(),
        gh<_i12.DeleteAllTasksUseCase>(),
        gh<_i11.ChangeTaskStatusUseCase>(),
      ));
  gh.factoryParam<_i16.UpdateTaskBloc, String, dynamic>((
    taskName,
    _,
  ) =>
      _i16.UpdateTaskBloc(
        gh<_i8.UpdateTaskUseCase>(),
        taskName: taskName,
      ));
  gh.factory<_i17.AddTaskBloc>(
      () => _i17.AddTaskBloc(gh<_i10.AddTaskUseCase>()));
  return getIt;
}
