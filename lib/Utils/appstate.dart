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

  MyAppState() {
    loadData();
  }

  void loadData() async {
    await dataHandler.loadAllLists();
    notifyListeners();
  }
}