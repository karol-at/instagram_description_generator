library stylepopups;

import 'package:flutter/material.dart';
import 'package:instagram_description_generator/Utils/appstate.dart';
import 'package:provider/provider.dart';

class ColorPopup extends StatelessWidget {
  const ColorPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(
      builder: (context, state, child) => SimpleDialog(
        insetPadding: const EdgeInsets.all(20),
        title: const Text('Select color'),
        children:[
          SizedBox(
            height: 300,
            width: 300,
            child: ListView.builder(
              itemCount: state.colors.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(state.colors[index]),
                onTap:() {
                  state.setColor(state.colors[index]);
                  Navigator.pop(context);
                },
              ),
            )
          ),
        ]
      ),
    );
  }
}