import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:what_to_eat/bloc_observer.dart';
import 'package:what_to_eat/blocs/app/app_bloc.dart';
import 'package:what_to_eat/presentation/router/app_router.dart';

import 'repositories/repositories.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authRepository = AuthRepository();
  runApp(App(authRepository: authRepository));
  Bloc.observer = AppBlocObserver();
}

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(key: key);

  final AuthRepository _authRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: BlocProvider(
        create: (_) => AppBloc(
          authRepository: _authRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlowBuilder<AppStatus>(
          state: context.select((AppBloc bloc) => bloc.state.status),
          onGeneratePages: onGenerateAppViewPages),
    );
  }
}
