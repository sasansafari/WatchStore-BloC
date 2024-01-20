part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoadingState extends AuthState {}

final class ErrorState extends AuthState {}

final class SentState extends AuthState {
  final mobile;
  SentState({required this.mobile});
}

final class VerifiedIsRegisterState extends AuthState {}

final class VerifiedNotRegisteState extends AuthState {}

final class LoggedInState extends AuthState {}

final class LoggedOutState extends AuthState {}
