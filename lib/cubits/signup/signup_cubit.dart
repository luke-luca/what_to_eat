import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '/repositories/repositories.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _authRepository;

  SignupCubit(this._authRepository) : super(SignupState.initial());

  void emailChanged(String value) {
    emit(
      state.copyWith(
        email: value,
        status: SignupStatus.initial,
      ),
    );
  }

  void passwordChanged(String value) {
    emit(
      state.copyWith(
        password: value,
        status: SignupStatus.initial,
      ),
    );
  }

  void rePasswordChanged(String value) {
    emit(
      state.copyWith(
        rePassword: value,
        status: SignupStatus.initial,
      ),
    );
  }

  void acceptTermsChanged(bool? value) {
    emit(
      state.copyWith(
        acceptTerms: value ?? false,
        status: SignupStatus.initial,
      ),
    );
  }

  Future<void> signupFormSubmitted() async {
    if (state.email.isEmpty ||
        state.password.isEmpty ||
        state.rePassword.isEmpty ||
        state.acceptTerms == false) {
      emit(state.copyWith(status: SignupStatus.error));
    } else {
      emit(state.copyWith(status: SignupStatus.submitting));
      try {
        await _authRepository.signup(
          email: state.email,
          password: state.password,
        );
        emit(state.copyWith(status: SignupStatus.success));
      } catch (_) {
        emit(state.copyWith(status: SignupStatus.error));
      }
    }
  }
}
