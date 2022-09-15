import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:what_to_eat/models/models.dart';

import '/repositories/repositories.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(LoginState.initial());

  void emailChanged(String value) {
    emit(
      state.copyWith(
        email: value,
        status: LoginStatus.initial,
      ),
    );
  }

  void passwordChanged(String value) {
    emit(
      state.copyWith(
        password: value,
        status: LoginStatus.initial,
      ),
    );
  }

  Future<void> logInWithCredentials() async {
    if (state.email.isEmpty || state.password.isEmpty) {
      return emit(state.copyWith(status: LoginStatus.error));
    } else {
      emit(state.copyWith(status: LoginStatus.submitting));
      try {
        await _authRepository.logInWithEmailAndPassword(
          email: state.email,
          password: state.password,
        );
        emit(state.copyWith(status: LoginStatus.success));
      } catch (_) {
        emit(state.copyWith(status: LoginStatus.error));
      }
    }
  }
}
