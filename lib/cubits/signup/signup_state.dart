part of 'signup_cubit.dart';

enum SignupStatus { initial, submitting, success, error }

class SignupState extends Equatable {
  final String email;
  final String password;
  final String rePassword;
  final bool acceptTerms;
  final SignupStatus status;

  SignupState({
    required this.email,
    required this.password,
    required this.rePassword,
    required this.acceptTerms,
    required this.status,
  });

  factory SignupState.initial() {
    return SignupState(
      email: '',
      password: '',
      rePassword: '',
      acceptTerms: false,
      status: SignupStatus.initial,
    );
  }

  SignupState copyWith({
    String? email,
    String? password,
    String? rePassword,
    bool? acceptTerms,
    SignupStatus? status,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      rePassword: rePassword ?? this.rePassword,
      acceptTerms: acceptTerms ?? this.acceptTerms,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, password, rePassword, acceptTerms, status];
}
