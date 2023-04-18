import 'package:flutter/material.dart';

import 'play_game/screens/game_page.dart';
import 'select_stage/screens/select_stage_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My 2048',
      debugShowCheckedModeBanner: false,
      initialRoute: SelectStagePage.routeName,
      routes: {
        SelectStagePage.routeName: (context) => const SelectStagePage(),
        GamePage.routeName: (context) => const GamePage(),
      },
    );
  }
}
