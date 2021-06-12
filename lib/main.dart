import 'package:flutter/material.dart';
import 'package:flutter_spend_dashboard/screens/dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme:ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xFF1B1E31),
      ),
      home: MyDashboard(),
    );
  }
}


