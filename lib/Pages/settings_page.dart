library settings_page;

import 'package:flutter/material.dart';
import 'package:instagram_description_generator/Utils/appstate.dart';
import 'package:instagram_description_generator/fonts/iconic_icons.dart';
import 'package:provider/provider.dart';
import 'package:instagram_description_generator/widgets/stylepopups.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  TextEditingController newCamera = TextEditingController();
  TextEditingController newLens = TextEditingController();
  String? removeCamera;
  String? removeLens;
  String? color;

  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(
      builder: (context, state, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Settings Page'),
        ),
        body: SizedBox.expand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Change app theme'),
              Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width > 500 ? 500 : MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FilledButton(
                      child: const Text('Change color'),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const ColorPopup();
                          },
                        );
                      }, 
                    ),
                    const SizedBox(width: 10),
                    Switch(
                      value: state.config.brightness, 
                      onChanged: (newValue){
                        state.config.brightness = newValue;
                        state.config.saveConfig();
                        state.changeTheme();
                      }
                    )
                  ],
                ),
              ),
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
                            controller: newCamera,
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
                          onPressed: (){
                            if(newCamera.text.isEmpty) {
                              return;
                            }
                            if(state.dataHandler.cameraList.contains(newCamera.text)){
                              return;
                            }
                            state.dataHandler.cameraList.add(newCamera.text);
                            state.dataHandler.saveList(state.dataHandler.cameraList, 'cameraList');
                            newCamera.clear();
                          },
                          icon: const Icon(Icons.add),
                          
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width > 500 ? 500 : MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(child: DropdownButton<String>(
                      value: removeCamera,
                      hint: const Text('Select a camera to remove'),
                      onChanged: (String? newValue) {
                        setState(() {
                          removeCamera = newValue;
                        });
                      },
                      items: state.dataHandler.cameraList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      )
                    ),
                    IconButton(
                      onPressed:(){
                        state.dataHandler.cameraList.remove(removeCamera);
                        state.dataHandler.saveList(state.dataHandler.cameraList, 'cameraList');
                        setState(() {
                          removeCamera = null;
                        });
                      }, 
                      icon: const Icon(IconicIcons.trash))
                  ],
                ),
              ),
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
                            controller: newLens,
                            decoration: const InputDecoration(
                              hintText: 'Add a lens',
                              
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: IconButton(
                          onPressed: (){
                            if(newLens.text.isEmpty) {
                              return;
                            }
                            if(state.dataHandler.lensList.contains(newLens.text)){
                              return;
                            }
                            state.dataHandler.lensList.add(newLens.text);
                            state.dataHandler.saveList(state.dataHandler.lensList, 'lensList');
                            newLens.clear();
                            state.rerender();
                          },
                          icon: const Icon(Icons.add),
                          
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width > 500 ? 500 : MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(child: DropdownButton<String>(
                      value: removeLens,
                      hint: const Text('Select a lens to remove'),
                      onChanged: (String? newValue) {
                        setState(() {
                          removeLens = newValue;
                        });
                      },
                      items: state.dataHandler.lensList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      )
                    ),
                    IconButton(
                      onPressed:(){
                        state.dataHandler.lensList.remove(removeLens);
                        state.dataHandler.saveList(state.dataHandler.lensList, 'lensList');
                        setState(() {
                          removeLens = null;
                        });
                      }, 
                      icon: const Icon(IconicIcons.trash))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

