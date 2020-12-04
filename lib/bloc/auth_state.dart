part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {
  final bool error;
  final String errorText;
  final bool success;

  AuthInitial({this.error = false, this.errorText, this.success = false});
}

class LoadingState extends AuthState {}
