// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:my_tasks_app/application/blocs/tasks/tasks_bloc.dart' as _i113;
import 'package:my_tasks_app/application/cubits/task_form_cubit/task_form_cubit.dart'
    as _i971;
import 'package:my_tasks_app/data/datasources/in_memory_task_datasource.dart'
    as _i1009;
import 'package:my_tasks_app/data/repositories_impl/task_repository_impl.dart'
    as _i763;
import 'package:my_tasks_app/domain/repositories/task_repository.dart' as _i572;
import 'package:my_tasks_app/domain/usecases/task_usecase.dart' as _i741;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i1009.TaskDataSource>(
      () => _i1009.InMemoryTaskDataSource(),
    );
    gh.lazySingleton<_i572.TaskRepository>(
      () => _i763.TaskRepositoryImpl(gh<_i1009.TaskDataSource>()),
    );
    gh.lazySingleton<_i741.TaskUsecase>(
      () => _i741.TaskUsecase(gh<_i572.TaskRepository>()),
    );
    gh.lazySingleton<_i113.TaskBloc>(
      () => _i113.TaskBloc(gh<_i741.TaskUsecase>()),
    );
    gh.factory<_i971.TaskFormCubit>(
      () => _i971.TaskFormCubit(gh<_i113.TaskBloc>()),
    );
    return this;
  }
}
