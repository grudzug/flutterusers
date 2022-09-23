import 'package:flutter/material.dart';
import 'package:mygetxapp/views/user_list.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const UserList(),
      },
    );
  }
}
