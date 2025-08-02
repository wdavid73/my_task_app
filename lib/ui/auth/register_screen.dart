import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_tasks_app/application/blocs/auth/auth_bloc.dart';
import 'package:my_tasks_app/application/cubits/register_form_cubit/register_form_cubit.dart';
import 'package:my_tasks_app/config/theme/theme.dart';
import 'package:my_tasks_app/ui/auth/widgets/wrapper_bloc_provider.dart';
import 'package:my_tasks_app/ui/widgets/custom_snack_bar.dart';
import 'package:my_tasks_app/ui/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Regístrate',
          style: context.textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: const _RegisterView(),
      ),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff3f5efb), Color(0xff00bcd4)],
          stops: [0.05, 1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Container(
          width: context.width,
          height: context.height,
          alignment: Alignment.center,
          child: const _RegisterBody(),
        ),
      ),
    );
  }
}

class _RegisterBody extends StatelessWidget {
  const _RegisterBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  FlutterLogo(size: context.dp(10)),
                  const SizedBox(height: 10),
                  Text('Regístrate', style: context.textTheme.titleMedium),
                  const SizedBox(height: 10),
                  const WrapperBlocProvidersAuth(child: _FormSignUp()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FormSignUp extends StatelessWidget {
  const _FormSignUp();

  @override
  Widget build(BuildContext context) {
    final authBlocState = context.watch<AuthBloc>().state;
    final registerCubit = context.watch<RegisterFormCubit>();
    final fullName = registerCubit.state.fullName;
    final email = registerCubit.state.email;
    final password = registerCubit.state.password;
    final confirmPassword = registerCubit.state.confirmPassword;

    void listenerShowSnackBar(BuildContext context, AuthState state) async {
      if (state.authStatus == AuthStatus.notAuthenticated &&
          state.errorMessage != '') {
        CustomSnackBar.showSnackBar(
          context,
          message: state.errorMessage,
          icon: Icons.warning_rounded,
          colorIcon: ColorTheme.error,
        );
      }
    }

    return BlocListener<AuthBloc, AuthState>(
      listener: listenerShowSnackBar,
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextFormField(
            textFormFieldKey: const Key('fullName_field'),
            label: 'Nombre',
            hint: 'Nombre',
            prefixIcon: const Icon(Icons.person_rounded),
            onChanged: registerCubit.fullNameChanged,
            errorMessage: fullName.errorMessage,
            initialValue: registerCubit.state.fullName.value,
          ),
          CustomTextFormField(
            textFormFieldKey: const Key('email_field'),
            label: 'Correo electrónico',
            hint: 'Correo electrónico',
            prefixIcon: const Icon(Icons.email_rounded),
            onChanged: registerCubit.emailChanged,
            errorMessage: email.errorMessage,
            initialValue: registerCubit.state.email.value,
            keyboardType: TextInputType.emailAddress,
          ),
          CustomTextFormField(
            textFormFieldKey: const Key('password_field'),
            label: 'Contraseña',
            hint: 'Contraseña',
            prefixIcon: const Icon(Icons.password),
            obscureText: registerCubit.state.isObscure,
            toggleObscure: registerCubit.toggleObscure,
            onChanged: registerCubit.passwordChanged,
            errorMessage: password.errorMessage,
            initialValue: registerCubit.state.password.value,
          ),
          CustomTextFormField(
            textFormFieldKey: const Key('confirm_password_field'),
            label: 'Confirmar contraseña',
            hint: 'Confirmar contraseña',
            prefixIcon: const Icon(Icons.password),
            obscureText: registerCubit.state.isObscure,
            toggleObscure: registerCubit.toggleObscure,
            onChanged: registerCubit.confirmPasswordChanged,
            errorMessage: confirmPassword.errorMessage,
            initialValue: registerCubit.state.confirmPassword.value,
          ),
          SizedBox(
            width: context.width,
            child: CustomButton(
              buttonKey: const Key('register_button'),
              label: 'Crear cuenta',
              icon: const Icon(Icons.login_rounded),
              isLoading: authBlocState.isCreating,
              onPressed: registerCubit.state.isPosting
                  ? null
                  : () => registerCubit.onSubmit(),
            ),
          ),
        ],
      ),
    );
  }
}
