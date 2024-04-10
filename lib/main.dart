
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Utils/appstate.dart';
import 'Pages/main_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  
  int currentPageIndex = 0;
  
  @override
  Widget build(BuildContext context) {
      var themeData = ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange, brightness: Brightness.light)
        );
    
    Widget page;
    page = HomePage(theme: themeData,);
    
    return ChangeNotifierProvider(
      create:(context) => MyAppState(),
      child: MaterialApp(
        theme: themeData,
        home: Scaffold(
            body: page,
              bottomNavigationBar:  NavigationBar(
                destinations:  const [
                  NavigationDestination(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.search),
                    label: 'Search',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.favorite),
                    label: 'Favorites',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.settings),
                    label: 'Settings',
                  ),
                ],
                selectedIndex: currentPageIndex,
                onDestinationSelected: (index) {
                  currentPageIndex = index;
                },
              )
        ),
      ),
    );
  }
}
