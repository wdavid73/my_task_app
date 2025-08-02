part of 'auth_bloc.dart';

mixin AuthBlocHandler on Bloc<AuthEvent, AuthState> {
  Future<void> handlerLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: AuthStatus.checking));

    final response = await (this as AuthBloc).useCase.login(
      event.email,
      event.password,
    );

    if (response is ResponseFailed) {
      emit(
        state.copyWith(
          authStatus: AuthStatus.notAuthenticated,
          user: null,
          errorMessage: response.error!.toString(),
        ),
      );
      return;
    }

    final authResponse = response.data;

    emit(
      state.copyWith(
        authStatus: AuthStatus.authenticated,
        user: authResponse,
        errorMessage: '',
      ),
    );
  }

  Future<void> handlerCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(authStatus: AuthStatus.checking));

    final response = await (this as AuthBloc).useCase.checkAuthStatus('');

    if (response is ResponseFailed) {
      emit(
        state.copyWith(
          authStatus: AuthStatus.notAuthenticated,
          user: null,
          errorMessage:
              response.error?.toString() ?? 'Error checking auth status',
        ),
      );
      return;
    }

    final authResponse = response.data;
    emit(
      state.copyWith(
        authStatus: AuthStatus.authenticated,
        user: authResponse,
        errorMessage: '',
      ),
    );
  }

  Future<void> handlerRegister(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isCreating: true));

    final response = await (this as AuthBloc).useCase.register(
      event.email,
      event.password,
      event.fullName,
    );

    if (response is ResponseFailed) {
      emit(
        state.copyWith(
          authStatus: AuthStatus.notAuthenticated,
          user: null,
          errorMessage: response.error!.toString(),
        ),
      );
      return;
    }
    final authResponse = response.data;

    emit(
      state.copyWith(
        isCreating: false,
        authStatus: AuthStatus.authenticated,
        user: authResponse,
        errorMessage: '',
      ),
    );
    return;
  }

  Future<void> handlerLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await (this as AuthBloc).useCase.logout();
    emit(
      state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        errorMessage: '',
        user: null,
      ),
    );
  }

  /* Future<void> _clearTokenAndEmitNotAuthenticated(
      Emitter<AuthState> emit) async {
    await (this as AuthBloc).keyValueStorageService.removeKey('token');
    emit(
      state.copyWith(
          authStatus: AuthStatus.notAuthenticated,
          errorMessage: '',
          user: null),
    );
  } */
}
