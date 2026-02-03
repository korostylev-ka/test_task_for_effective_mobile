import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task_effective_mobile/presentation/favourite_screen.dart';
import 'package:test_task_effective_mobile/presentation/main_screen.dart';
import 'package:test_task_effective_mobile/resources/strings.dart';
import 'package:test_task_effective_mobile/state/app_state.dart';

import 'data/db/db_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.android) {
    DBService.instance();
  }
  runApp(
      ChangeNotifierProvider(
          create: (context) => AppState(),
          child: MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/favourite': (context) => FavouriteScreen()
      },
      title: Strings.projectTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      )
    );
  }
}


