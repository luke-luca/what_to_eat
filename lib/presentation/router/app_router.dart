import 'package:flutter/widgets.dart';
import 'package:what_to_eat/blocs/app/app_bloc.dart';
import 'package:what_to_eat/presentation/screens/home/home_page.dart';

import '../screens/screens.dart';

List<Page> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomeScreen.page()];
    case AppStatus.unauthenticated:
      return [LoginScreen.page()];
  }
}
