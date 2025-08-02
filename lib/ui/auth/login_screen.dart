import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_tasks_app/application/blocs/auth/auth_bloc.dart';
import 'package:my_tasks_app/application/cubits/login_form_cubit/sign_in_form_cubit.dart';
import 'package:my_tasks_app/config/theme/theme.dart';
import 'package:my_tasks_app/ui/auth/widgets/wrapper_bloc_provider.dart';
import 'package:my_tasks_app/ui/shared/styles/app_spacing.dart';
import 'package:my_tasks_app/ui/widgets/custom_snack_bar.dart';
import 'package:my_tasks_app/ui/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Iniciar Sesión',
          style: context.textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: const _LoginView(),
      ),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

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
          child: const _LoginBody(),
        ),
      ),
    );
  }
}

class _LoginBody extends StatelessWidget {
  const _LoginBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    FlutterLogo(size: context.dp(10)),
                    const SizedBox(height: 10),
                    Text(
                      'Iniciar Sesión',
                      style: context.textTheme.titleMedium,
                    ),
                    AppSpacing.sm,

                    const WrapperBlocProvidersAuth(child: _FormSignIn()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 5,
                      children: [
                        Text(
                          'No tienes una cuenta,',
                          style: context.textTheme.labelMedium,
                        ),
                        TextButton(
                          key: const Key('go_to_register_screen'),
                          onPressed: () => context.pushNamed('register'),
                          child: Text(
                            'Crea una aquí',
                            style: context.textTheme.labelMedium?.copyWith(
                              decoration: TextDecoration.underline,
                              fontWeight: AppTypography.semiBoldWeight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormSignIn extends StatelessWidget {
  const _FormSignIn();

  @override
  Widget build(BuildContext context) {
    final signInForm = context.watch<SignInFormCubit>();
    final email = signInForm.state.email;
    final password = signInForm.state.password;

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
            textFormFieldKey: const Key('email_field'),
            label: 'Email',
            hint: 'Input your email',
            prefixIcon: const Icon(Icons.email_rounded),
            onChanged: signInForm.emailChanged,
            errorMessage: email.errorMessage,
            initialValue: signInForm.state.email.value,
            keyboardType: TextInputType.emailAddress,
          ),
          CustomTextFormField(
            textFormFieldKey: const Key('password_field'),
            label: 'Password',
            hint: 'Input your password',
            obscureText: signInForm.state.isObscure,
            toggleObscure: signInForm.toggleObscure,
            prefixIcon: const Icon(Icons.password),
            onChanged: signInForm.passwordChanged,
            errorMessage: password.errorMessage,
            initialValue: signInForm.state.password.value,
            maxLines: 1,
          ),
          SizedBox(
            width: context.width,
            child: FilledButton.icon(
              key: const Key('login_button'),
              onPressed: signInForm.state.isPosting
                  ? null
                  : () => signInForm.onSubmit(),
              icon: const Icon(Icons.login_rounded),
              label: const Text('Sign in'),
            ),
          ),
        ],
      ),
    );
  }
}
