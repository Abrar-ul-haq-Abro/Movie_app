import 'package:flutter/material.dart';
import 'app/app.locator.dart';
import 'app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import 'core/constants/app_strings.dart';
import 'ui/views/movie_list/movie_list_view.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      home: const MovieListView(),
    );
  }
}
