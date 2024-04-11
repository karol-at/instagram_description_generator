library main_page;

import 'package:flutter/material.dart';
import 'package:instagram_description_generator/Utils/list_loader.dart';

class HomePage extends StatefulWidget {
  final DataHandler dataHandler;
  final int dropdownValue = 0;
  const HomePage({super.key, required ThemeData theme, required this.dataHandler,});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const  Text('Home Page'),
      ),
      body: Center(
        child: Column(
          
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Title'

                ),
              ),
            ),
            Padding(padding: const EdgeInsets.all(20),
            child: DropdownButton<String>(
                hint: const Text('Select a camera'),
                onChanged: (String? newValue) {
                  setState(() {
                  });
                },
                items: widget.dataHandler.cameraList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList()
              ),
            )
          ],
        ),
      ),
    );
  }
}