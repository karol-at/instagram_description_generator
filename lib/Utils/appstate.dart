library appstate;

import 'package:flutter/material.dart';
import 'package:instagram_description_generator/Utils/config.dart';
import 'package:instagram_description_generator/Utils/description_creator.dart';
import 'package:instagram_description_generator/Utils/list_loader.dart';

class MyAppState extends ChangeNotifier{
  DataHandler dataHandler = DataHandler();
  Description descriptionCreator = Description(
    title: "",
    camera: "",
    lens: "",
    tags: [],
    hashtags: [],
  );
  TextEditingController titleController = TextEditingController();
  Config config = Config();
  ThemeData themeData = ThemeData();
  ThemeData negThemeData = ThemeData();
  final List<String> colors = appColors.keys.toList();
  
  
  void changeTheme() {
    themeData = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: appColors[config.color]!, brightness: config.brightness? Brightness.dark: Brightness.light),
    );
    negThemeData = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: appColors[config.color]!, brightness: config.brightness? Brightness.light: Brightness.dark),
    );
    notifyListeners();
  }
    
    

  MyAppState() {
    loadData();
  }

  void loadData() async {
    await dataHandler.loadAllLists();
    await config.loadConfig();
    changeTheme();
  }

  void checkHahstag(String hashtag) {
    if(descriptionCreator.hashtags.contains(hashtag)) {
      descriptionCreator.hashtags.remove(hashtag);
    } else {
      descriptionCreator.hashtags.add(hashtag);
    }
    notifyListeners();
  }

  void rerender() {
    notifyListeners();
  }
}