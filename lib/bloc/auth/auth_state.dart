
part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();

  @override
  List<Object> get props => [];
}

class AuthLogin extends AuthState {
  final User? user;
  final String? message;

  const AuthLogin(this.user,this.message);

  @override
  List<Object> get props => [this.user!,this.message!];
}

class AuthLoginFailed extends AuthState {
  final String? message;

  const AuthLoginFailed(this.message);

  @override
  List<Object> get props => [this.message!];
}


class UnAuthenticated extends AuthState {
  const UnAuthenticated();

  @override
  List<Object> get props => [];
}

class AuthFailed extends AuthState {
  final String? message;

  const AuthFailed(this.message);

  @override
  List<Object> get props => [this.message!];
}

class Authenticated extends AuthState {
  final User? user;

  const Authenticated(this.user);

  @override
  List<Object> get props => [this.user!];
}