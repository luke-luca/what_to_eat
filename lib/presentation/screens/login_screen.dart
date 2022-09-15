import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:what_to_eat/presentation/screens/forget_screen.dart';
import 'package:what_to_eat/presentation/screens/screens.dart';

import '/cubits/cubits.dart';
import '/repositories/repositories.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocProvider(
          create: (_) => LoginCubit(context.read<AuthRepository>()),
          child: const LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.error) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Login Failure'),
              ),
            );
        }
      },
      child: ListView(
        children: [
          Image.asset(
            'assets/images/login_background.png',
            height: 300,
          ),
          const SizedBox(height: 16),
          _EmailInput(),
          const SizedBox(height: 8),
          _PasswordInput(),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: _ForgotPasswordButton(),
          ),
          _LoginButton(),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Don\'t have an account?'),
              _SignupButton(),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          onChanged: (email) {
            context.read<LoginCubit>().emailChanged(email);
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
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          onChanged: (password) {
            context.read<LoginCubit>().passwordChanged(password);
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

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == LoginStatus.submitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(275, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: Colors.red,
                  primary: Colors.redAccent,
                ),
                onPressed: () {
                  context.read<LoginCubit>().logInWithCredentials();
                },
                child: const Text('Login', style: TextStyle(fontSize: 20)),
              );
      },
    );
  }
}

class _SignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).push<void>(SignupScreen.route()),
      child: const Text(
        'Create Account!',
        style: TextStyle(color: Colors.redAccent),
      ),
    );
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ElevatedButton.styleFrom(
        alignment: Alignment.centerRight,
      ),
      onPressed: () => Navigator.of(context).push<void>(ForgetScreen.route()),
      child: const Text(
        'Forget password?!',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
