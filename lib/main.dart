
import 'package:flutter/material.dart';
import 'package:instagram_description_generator/Utils/list_loader.dart';
import 'package:provider/provider.dart';
import 'Pages/main_page.dart';
import 'Pages/hashtags_page.dart';
import 'Pages/tags_page.dart';
import 'Pages/settings_page.dart';
import 'fonts/iconic_icons.dart';

DataHandler startupDataHandler = DataHandler();
void main() async {
  await startupDataHandler.loadAllLists();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  
  int currentPageIndex = 0;
  DataHandler dataHandler = startupDataHandler;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
      var themeData = ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange, brightness: Brightness.light)
        );
    
    Widget page;
    switch (currentPageIndex) {
      case 0:
        page = HomePage(theme: themeData, dataHandler: dataHandler);
      case 1:
        page = HashtagsPage(theme: themeData, dataHandler: dataHandler);
      case 2:
        page = TagsPage(theme: themeData, dataHandler: dataHandler);
      case 3:
        page = SettingsPage(theme: themeData, dataHandler: dataHandler);
      default:
        page = const Placeholder();
    }
    
    return ChangeNotifierProvider(
      create:(context) => MyAppState(),
      child: MaterialApp(
        theme: themeData,
        home: Scaffold(
            body: page,
              bottomNavigationBar:  NavigationBar(
                destinations:  const [
                  NavigationDestination(
                    icon: Icon(IconicIcons.home),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(IconicIcons.hash),
                    label: 'Hashtags',
                  ),
                  NavigationDestination(
                    icon: Icon(IconicIcons.at),
                    label: 'Tags',
                  ),
                  NavigationDestination(
                    icon: Icon(IconicIcons.cog),
                    label: 'Settings',
                  ),
                ],
                selectedIndex: currentPageIndex,
                onDestinationSelected: (index) {
                  setState(() {
                    currentPageIndex = index;
                  });
                },
              )
        ),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier{
}
