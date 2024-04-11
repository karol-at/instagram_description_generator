library data_handler;

import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';


class DataHandler{

  List<String> cameraList = [];
  List<String> lensList = [];
  List<String> tagsList = [];
  List<String> categoryList = [];
  List<List<String>> hashtagList = [];

  void saveList (List<String> list, String listName) async {
  final path = await getLocalJsonPath(listName);
  if (list.isEmpty) {
    return;
  }


  final file = File(path);
  final data = jsonEncode(list);
  file.writeAsString(data);
  return;
  }

  void loadAllLists() async {
  cameraList = await loadList('cameraList');
  lensList = await loadList('lensList');
  tagsList = await loadList('tagsList');
  categoryList = await loadList('categoryList');
  hashtagList = await loadHashtagList();
  }

  Future<List<List<String>>> loadHashtagList() async {
    List<List<String>> output = [];
    for (String list in categoryList) 
    {
      output.add(await loadList(list));
    }
    return output;
  }


Future<String> getLocalJsonPath(String filename) async {
    final directory = await getApplicationSupportDirectory();
    return '${directory.path}/$filename.json';
}

Future<List<String>> loadList(String listName) async {
  final path = await getLocalJsonPath(listName);
  final file = File(path);
  if (!await file.exists()) {
    return [];
  }
  final data = await file.readAsString();
  final list = List<String>.from(jsonDecode(data));
  return list;
}
} 

