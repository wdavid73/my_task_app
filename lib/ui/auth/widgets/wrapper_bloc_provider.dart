import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_tasks_app/application/blocs/auth/auth_bloc.dart';
import 'package:my_tasks_app/application/cubits/login_form_cubit/sign_in_form_cubit.dart';
import 'package:my_tasks_app/application/cubits/register_form_cubit/register_form_cubit.dart';
import 'package:my_tasks_app/core/di/injection.dart';

class WrapperBlocProvidersAuth extends StatelessWidget {
  final Widget child;
  const WrapperBlocProvidersAuth({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final authBloc = getIt.get<AuthBloc>();
    final signInCubit = getIt.get<SignInFormCubit>();
    final registerCubit = getIt.get<RegisterFormCubit>();

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authBloc),
        BlocProvider(create: (context) => signInCubit),
        BlocProvider(create: (context) => registerCubit),
      ],
      child: child,
    );
  }
}
