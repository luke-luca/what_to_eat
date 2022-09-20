import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:what_to_eat/logic/blocs/blocs.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  static Page page() => const MaterialPage<void>(child: SettingsScreen());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const TextButton(
            onPressed: null,
            child: Text('Change Password'),
          ),
          const TextButton(
            onPressed: null,
            child: Text('Change Email'),
          ),
          TextButton(
            onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
