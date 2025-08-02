// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:my_tasks_app/application/blocs/auth/auth_bloc.dart' as _i595;
import 'package:my_tasks_app/application/blocs/tasks/tasks_bloc.dart' as _i113;
import 'package:my_tasks_app/application/cubits/login_form_cubit/sign_in_form_cubit.dart'
    as _i917;
import 'package:my_tasks_app/application/cubits/register_form_cubit/register_form_cubit.dart'
    as _i510;
import 'package:my_tasks_app/application/cubits/task_form_cubit/task_form_cubit.dart'
    as _i971;
import 'package:my_tasks_app/core/di/module.dart' as _i203;
import 'package:my_tasks_app/data/datasources/firebase_auth_datasource.dart'
    as _i623;
import 'package:my_tasks_app/data/datasources/in_memory_task_datasource.dart'
    as _i1009;
import 'package:my_tasks_app/data/repositories_impl/auth_repository_impl.dart'
    as _i837;
import 'package:my_tasks_app/data/repositories_impl/task_repository_impl.dart'
    as _i763;
import 'package:my_tasks_app/domain/repositories/auth_repository.dart' as _i377;
import 'package:my_tasks_app/domain/repositories/task_repository.dart' as _i572;
import 'package:my_tasks_app/domain/usecases/auth_usecase.dart' as _i418;
import 'package:my_tasks_app/domain/usecases/task_usecase.dart' as _i741;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final firebaseModule = _$FirebaseModule();
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
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
    gh.lazySingleton<_i623.AuthDataSource>(
      () => _i623.FirebaseAuthDataSource(gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i377.AuthRepository>(
      () => _i837.AuthRepositoryImpl(gh<_i623.AuthDataSource>()),
    );
    gh.lazySingleton<_i418.AuthUseCase>(
      () => _i418.AuthUseCase(gh<_i377.AuthRepository>()),
    );
    gh.factory<_i971.TaskFormCubit>(
      () => _i971.TaskFormCubit(gh<_i113.TaskBloc>()),
    );
    gh.lazySingleton<_i595.AuthBloc>(
      () => _i595.AuthBloc(gh<_i418.AuthUseCase>()),
    );
    gh.factory<_i510.RegisterFormCubit>(
      () => _i510.RegisterFormCubit(authBloc: gh<_i595.AuthBloc>()),
    );
    gh.factory<_i917.SignInFormCubit>(
      () => _i917.SignInFormCubit(authBloc: gh<_i595.AuthBloc>()),
    );
    return this;
  }
}

class _$FirebaseModule extends _i203.FirebaseModule {}
