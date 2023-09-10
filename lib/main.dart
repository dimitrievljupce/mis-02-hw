import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_together/core/services/file_service.dart';
import 'package:work_together/screens/dashboard_screen/darshboard_screen_viewmodel.dart';
import 'package:work_together/screens/map_screen/map_screen_viewmodel.dart';

import 'screens/dashboard_screen/dashboard_screen.dart';
import 'screens/new_place_screen/new_place_screen_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => DashboardScreenViewModel()),
          ChangeNotifierProvider(
              create: (_) => MapScreenViewModel(fileService: FileService())),
          ChangeNotifierProvider(create: (_) => NewPlaceViewModel()),
        ],
        child: const MaterialApp(
          home: DashboardScreen(),
        ),
      ),
    );
  }
}
