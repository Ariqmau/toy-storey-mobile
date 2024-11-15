import 'package:flutter/material.dart';
import 'package:toy_storey/screens/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toy Storey',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.lightBlue,
        ).copyWith(secondary: Colors.lightBlueAccent),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
