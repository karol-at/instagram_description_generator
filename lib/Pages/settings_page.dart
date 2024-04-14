library settings_page;

import 'package:flutter/material.dart';
import 'package:instagram_description_generator/Utils/appstate.dart';
import 'package:provider/provider.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  TextEditingController newCamera = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(
      builder: (context, state, child) => Scaffold(
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
                          state.dataHandler.addCamera(newCamera);
                          newCamera.clear();
                        },
                        icon: const Icon(Icons.add),
                        
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

