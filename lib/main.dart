import 'package:coffee_app/home.page.dart';
import 'package:flutter/material.dart';

import 'config/services_locator.dart';

void main() {
  initServicesLocator();
  runApp(const CoffeApp());
}

class CoffeApp extends StatelessWidget {
  const CoffeApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("IZR / Flutter App Challenge - Coffee App (Flutter 3.7.1)");
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      // showPerformanceOverlay: true,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
