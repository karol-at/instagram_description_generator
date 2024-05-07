library appstate;

import 'package:flutter/material.dart';
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
  //TODO: change this to load on app initialization
  ThemeData themeData = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow, brightness: Brightness.dark),
  );
  final List<String> colors = ['orange', 'blue', 'green', 'red', 'yellow', 'purple'];
  //TODO: Save selected color
  Color color = Colors.yellow;
  Brightness brightness = Brightness.dark;

  void setColor(Color color) {
    themeData = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: color, brightness: brightness),
    );
    notifyListeners();
  }
      
    

  MyAppState() {
    loadData();
  }

  void loadData() async {
    await dataHandler.loadAllLists();
    notifyListeners();
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

  void changeColor(String color)
  {
    switch (color) {
      case 'orange':
        setColor(Colors.orange);
        break;
      case 'blue':
        setColor(Colors.blue);
        break;
      case 'green':
        setColor(Colors.green);
        break;
      case 'red':
        setColor(Colors.red);
        break;
      case 'yellow':
        setColor(Colors.yellow);
        break;
      case 'purple':  
        setColor(Colors.purple);
        break; 
      }
  }
}