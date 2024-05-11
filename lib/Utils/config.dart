library config;

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Config{
  bool brightness = true;
  //TODO: create colors enum
  String color = 'yellow';

  Future<void> loadConfig() async {
    final directory = await getApplicationSupportDirectory();
    final path = '${directory.path}/config.json';
    final file = File(path);
    if (!await file.exists())
    {
      return;
    }
    final data = await file.readAsString();
    if (data.isEmpty)
    {
      return;
    }
    Map<String, dynamic> json = jsonDecode(data);
    Config config = Config.fromJson(json);
    color = config.color;
    brightness = config.brightness;
  }
  Future<void> saveConfig() async {
    final directory = await getApplicationSupportDirectory();
    final path = '${directory.path}/config.json';
    final file = File(path);
    final data = jsonEncode(this);
    await file.writeAsString(data);
  }
  Config({this.brightness = true, this.color = 'yellow'});

  Config.fromJson(Map<String, dynamic> json) :
    brightness = json['brightness'] as bool,
    color = json['color'] as String;
  

  Map<String, dynamic> toJson() => {
      'brightness': brightness,
      'color': color,
  };
}

Map<String, Color> appColors = {
  'orange': Colors.orange,
  'blue': Colors.blue,
  'green': Colors.green,
  'red': Colors.red,
  'yellow': Colors.yellow,
  'purple': Colors.purple,
};