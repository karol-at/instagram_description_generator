import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  

  @override
  Widget build(BuildContext context) {
    Widget page;
    page = const Placeholder();
    return MaterialApp(

      home: Scaffold(
        body: Column(
          children: [
            page,
            const TabBar(tabs: [
              Tab(text: 'home',),
              Tab(text: 'hashtags',),
              Tab(text: 'tags',),
              Tab(text: 'settings',),
              ]
            )
          ],
        )
      ),
    );
  }
}
