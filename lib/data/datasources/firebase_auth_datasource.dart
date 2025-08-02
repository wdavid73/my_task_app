import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:my_tasks_app/core/api/response.dart';
import 'package:my_tasks_app/data/models/user_model.dart';

/// Defines the contract for authentication-related operations.
///
/// Implementations of this class are responsible for handling user authentication,
/// including login, registration, and authentication status verification.
abstract class AuthDataSource {
  /// Authenticates a user with the given credentials.
  ///
  /// Attempts to log in a user using their [email] and [password].
  ///
  /// Returns:
  ///   - [ResponseSuccess]: If authentication is successful, containing user data and a token.
  ///   - [ResponseFailed]: If authentication fails, containing an error message.
  ///
  /// Parameters:
  ///   - [email]: The user's email address.
  ///   - [password]: The user's password.
  ///
  Future<ResponseState> login(String email, String password);

  /// Registers a new user with the provided details.
  ///
  /// Creates a new account using the given [email], [password], and [fullName].
  ///
  /// Returns:
  ///   - [ResponseSuccess]: If registration is successful, containing user data and a token.
  ///   - [ResponseFailed]: If registration fails, containing an error message.
  ///
  /// Parameters:
  ///   - [email]: The user's email address.
  ///   - [password]: The user's chosen password.
  ///   - [fullName]: The user's full name.
  ///
  Future<ResponseState> register(
    String email,
    String password,
    String fullName,
  );

  /// Checks the authentication status of a user.
  ///
  /// Validates whether the provided authentication [token] is still valid.
  ///
  /// Returns:
  ///   - [ResponseSuccess]: If the token is valid, containing user session details.
  ///   - [ResponseFailed]: If the token is invalid or expired, containing an error message.
  ///
  /// Parameters:
  ///   - [token]: The authentication token to verify.
  ///
  Future<ResponseState> checkAuthStatus(String token);

  Future<void> logout();
}

@LazySingleton(as: AuthDataSource)
class FirebaseAuthDataSource extends AuthDataSource {
  User? _user;
  final FirebaseAuth _auth;
  final Completer<void> _completer = Completer();

  FirebaseAuthDataSource(this._auth) {
    _init();
  }

  void _init() async {
    _auth.authStateChanges().listen((User? user) {
      if (!_completer.isCompleted) {
        _completer.complete();
      }
      _user = user;
    });
  }

  Future<User?> get user async {
    await _completer.future;
    return _user;
  }

  @override
  Future<ResponseState> checkAuthStatus(String token) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        return const ResponseFailed('No user logged in.');
      }

      final UserModel user = UserModel(
        id: currentUser.uid,
        email: currentUser.email!,
        fullName: currentUser.displayName ?? 'User',
      );

      return ResponseSuccess(user, 200);
    } catch (e) {
      return ResponseFailed(e.toString());
    }
  }

  @override
  Future<ResponseState> login(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);

      final UserModel user = UserModel(
        id: userCredential.user!.uid,
        email: userCredential.user!.email!,
        fullName: userCredential.user!.displayName ?? 'User',
      );
      return ResponseSuccess(user, 200);
    } on FirebaseAuthException catch (e) {
      return ResponseFailed(e.code);
    } catch (e) {
      return ResponseFailed(e.toString());
    }
  }

  @override
  Future<ResponseState> register(
    String email,
    String password,
    String fullName,
  ) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user!;
      final userModel = UserModel(
        id: user.uid,
        email: email,
        fullName: fullName,
      );

      return ResponseSuccess(userModel, 201);
    } on FirebaseAuthException catch (e) {
      return ResponseFailed(e.code);
    } on PlatformException catch (e) {
      return ResponseFailed(e.code);
    } catch (e) {
      return ResponseFailed(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    return await _auth.signOut();
  }
}
