import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skilltest/blocs/form_bloc.dart';
import 'package:skilltest/screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => FormBloc(),
      child: MaterialApp(
        title: 'Question 4',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
