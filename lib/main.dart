import 'package:flutter/material.dart';
import 'package:movie_app_eateasy/movieapp_theme.dart';
import 'views/movie_list_view.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: MovieappTheme.primaryAppColor,
        primarySwatch: MovieappTheme.customSwatch,
      ),
      home: MovieListView(),
    );
  }
}
