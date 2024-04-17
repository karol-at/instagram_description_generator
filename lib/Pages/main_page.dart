library main_page;

import 'package:flutter/material.dart';
import 'package:instagram_description_generator/Utils/appstate.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final int dropdownValue = 0;
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(
      builder: (context, state, child) => Scaffold(
        appBar: AppBar(
          title: const  Text('Home Page'),
        ),
        body: Center(
          child: Column(
            
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: 'Title'
      
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: DropdownButton<String>(
                  value: state.descriptionCreator.camera.isNotEmpty ? state.descriptionCreator.camera : null,
                  hint: const Text('Select a camera'),
                  onChanged: (String? newValue) {
                    setState(() {
                      state.descriptionCreator.camera = newValue!;
                    });
                  },
                  items: state.dataHandler.cameraList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                   );
                  }).toList()
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: DropdownButton<String>(
                  value: state.descriptionCreator.lens.isNotEmpty ? state.descriptionCreator.lens : null,
                  hint: const Text('Select a lens'),
                  onChanged: (String? newValue) {
                    setState(() {
                      state.descriptionCreator.lens = newValue!;
                    });
                  },
                  items: state.dataHandler.lensList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList()
                ),
              ),
              Padding(padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    state.descriptionCreator.title = state.titleController.text;
                    state.descriptionCreator.createDescription();
                    setState(() {});
                  },
                  child: const Text('Generate Description'),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: state.descriptionCreator.description),
                  maxLines: 10,
                  readOnly: true,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}