library settings_page;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_description_generator/Utils/list_loader.dart';

class SettingsPage extends StatefulWidget {
  DataHandler dataHandler;
  TextEditingController newCamera = TextEditingController();
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
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      
                      height: 50,
                      child: TextField(
                        controller: widget.newCamera,
                        decoration: const InputDecoration(
                          hintText: 'Add a camera',
                          
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: IconButton(
                      onPressed: addCamera,
                      icon: const Icon(Icons.add),
                      
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
  void addCamera() {
    widget.dataHandler.cameraList.add(widget.newCamera.text);
    widget.newCamera.clear();
    setState(() {
    });
    widget.dataHandler.saveList(widget.dataHandler.cameraList, 'cameraList');
  }
}

