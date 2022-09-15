import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/cubits/cubits.dart';
import '/repositories/repositories.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignupScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocProvider<SignupCubit>(
          create: (_) => SignupCubit(context.read<AuthRepository>()),
          child: const SignupForm(),
        ),
      ),
    );
  }
}

class SignupForm extends StatelessWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state.status == SignupStatus.success) {
          Navigator.of(context).pop();
        } else if (state.status == SignupStatus.error) {
          // Nothing for now.
        }
      },
      child: ListView(
        children: [
          Image.asset(
            'assets/images/login_background.png',
            height: 300,
          ),
          _EmailInput(),
          const SizedBox(height: 8),
          _PasswordInput(),
          const SizedBox(height: 8),
          _RePasswordInput(),
          const SizedBox(height: 8),
          Row(
            children: const [
              _AcceptTermsButton(),
              Text('I accept the terms and conditions'),
            ],
          ),
          const SizedBox(height: 8),
          _SignupButton(),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text('Already have an account?'), _BackButton()],
          ),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          onChanged: (email) {
            context.read<SignupCubit>().emailChanged(email);
          },
          decoration: const InputDecoration(
            fillColor: Colors.redAccent,
            labelText: 'email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            prefixIcon: Icon(Icons.email),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          onChanged: (password) {
            context.read<SignupCubit>().passwordChanged(password);
          },
          decoration: const InputDecoration(
            fillColor: Colors.redAccent,
            labelText: 'password',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            prefixIcon: Icon(Icons.lock),
          ),
          obscureText: true,
        );
      },
    );
  }
}

class _RePasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) =>
          previous.rePassword != current.rePassword,
      builder: (context, state) {
        return TextFormField(
          onChanged: (rePassword) {
            context.read<SignupCubit>().rePasswordChanged(rePassword);
          },
          decoration: const InputDecoration(
            fillColor: Colors.redAccent,
            labelText: 're-password',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            prefixIcon: Icon(Icons.lock),
          ),
          obscureText: true,
        );
      },
    );
  }
}

class _AcceptTermsButton extends StatelessWidget {
  const _AcceptTermsButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: context.read<SignupCubit>(),
      builder: (context, state) {
        return Checkbox(
          value: state.acceptTerms,
          onChanged: (value) {
            context.read<SignupCubit>().acceptTermsChanged(value);
          },
        );
      },
    );
  }
}

class _SignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == SignupStatus.submitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(275, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.redAccent,
                ),
                onPressed: () {
                  context.read<SignupCubit>().signupFormSubmitted();
                },
                child: const Text('Sign Up', style: TextStyle(fontSize: 20)),
              );
      },
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: (() => Navigator.of(context).pop()),
        style: TextButton.styleFrom(
          foregroundColor: Colors.redAccent,
        ),
        child: const Text('Sign In'));
  }
}
