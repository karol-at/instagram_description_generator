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
  //TODO: Save selected color
  ThemeData themeData = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow, brightness: Brightness.dark),
  );

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
}