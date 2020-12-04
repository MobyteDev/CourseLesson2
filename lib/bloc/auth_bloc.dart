import 'dart:async';
import 'package:auth_test/firebase/auth.dart';
import 'package:auth_test/firebase/exceptions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());
  Auth auth = Auth();
  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield LoadingState();
    try {
      if (event is SignInEvent) {
        await auth.signIn(event.email, event.password);
        yield AuthInitial(success: true);
      }
      if (event is SignUpEvent) {
        await auth.signIn(event.email, event.password);
        yield AuthInitial(success: true);
      }
    } on AuthException catch (exception) {
      yield AuthInitial(error: true, errorText: exception.caption);
    }
  }
}
