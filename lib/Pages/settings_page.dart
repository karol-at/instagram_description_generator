library settings_page;

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:instagram_description_generator/Utils/list_loader.dart';

class SettingsPage extends StatefulWidget {
  DataHandler dataHandler;
  String newCamera = '';
  SettingsPage({super.key, required ThemeData theme, required this.dataHandler});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width > 500 ? 500 : MediaQuery.of(context).size.width,
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      
                      height: 50,
                      child: const TextField(
                        
                        decoration: InputDecoration(
                          hintText: 'Add a camera',
                          
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                    height: 50,
                    child: IconButton(
                      onPressed: addCamera,
                      icon: Icon(Icons.add),
                      
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  static void addCamera() {
  
  
  }
}

