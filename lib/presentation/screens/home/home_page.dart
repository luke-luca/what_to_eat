import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static Page page() => const MaterialPage<void>(child: HomePage());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: const [
                Text('Hi John'),
                Text('What would you like to cook?'),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
          ],
        ),
      ),
    );
  }
}
