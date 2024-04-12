library data_handler;

import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';


class DataHandler{

  List<String> cameraList = [];
  List<String> lensList = [];
  List<Tag> tagsList = [];
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

  Future<void> loadAllLists() async {
  cameraList = await loadList('cameraList');
  lensList = await loadList('lensList');
  tagsList = await loadTagsList();
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

  Future<List<Tag>> loadTagsList() async {
    List<Tag> output = [];
    List<String> tempTagsList = await loadList('tagsList');
    List<String> tempHashtagsList = await loadList('tagHashtagsList');
    for (int i = 0; i < tempTagsList.length; i++) {
      output.add(Tag(tag: tempTagsList[i], hashtag: tempHashtagsList[i]));
    }
    return output;
  }

  Future<void> saveTagsList() async {
    List<String> tempTagsList = [];
    List<String> tempHashtagsList = [];
    for (Tag tag in tagsList) {
      tempTagsList.add(tag.tag);
      tempHashtagsList.add(tag.hashtag);
    }
    saveList(tempTagsList, 'tagsList');
    saveList(tempHashtagsList, 'tagHashtagsList');
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

class Tag {
  String tag;
  String hashtag;
  Tag({required this.tag, this.hashtag = ''})
  {
    if (hashtag == '') {
      hashtag = tag;
    }
  }
}