library hashtags_page;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_description_generator/Utils/appstate.dart';
import 'package:provider/provider.dart';

class HashtagsPage extends StatefulWidget {
  const HashtagsPage({super.key});

  @override
  State<HashtagsPage> createState() => _HashtagsPageState();
}

class _HashtagsPageState extends State<HashtagsPage> {

  TextEditingController categoryController = TextEditingController();
  TextEditingController hashtagController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(
      builder: (context, state, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Hashtags'),
        ),
        body: Column(
          children: [
            
            Expanded(
              child: ListView.builder(
                itemCount: state.dataHandler.categoryList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      //TODO: figure out the color scheme
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: Text(state.dataHandler.categoryList[index], style: Theme.of(context).textTheme.titleMedium,)
                          ),
                        Wrap(
                          children: [
                            for (String hashtag in state.dataHandler.hashtagList[index])
                            //TODO: make this a button and figure out how to control selection
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                child: Text('#$hashtag'),
                              ),
                          ],
                        ),
                      ],
                    )
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(context: context, builder: (context) => SimpleDialog(
              title: const Text('Add a new hashtag'),
              contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
              children: [
                  TextField(
                    //TODO: this probably should be a dropdown
                    decoration: const InputDecoration(
                      hintText: 'Category name',
                      prefix: SizedBox(width: 15),
                    ),
                    controller: categoryController,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Hashtag',
                      prefix: SizedBox(width: 15, child: Text('#')),
                    ),
                    controller: hashtagController,
                  ),
                  TextButton(onPressed: (){
                    if (categoryController.text.isEmpty || hashtagController.text.isEmpty) {
                      return;
                    }
                    if (!state.dataHandler.categoryList.contains(categoryController.text)) {
                      state.dataHandler.categoryList.add(categoryController.text);
                      state.dataHandler.saveList(state.dataHandler.categoryList, 'categoryList');
                      state.dataHandler.hashtagList.add([]);
                    }
                    int index = state.dataHandler.categoryList.indexOf(categoryController.text);
                    if (!state.dataHandler.hashtagList[index].contains(hashtagController.text)) {
                      state.dataHandler.hashtagList[index].add(hashtagController.text);
                    }
                    state.dataHandler.saveList(state.dataHandler.hashtagList[index], state.dataHandler.categoryList[index]);
                    Navigator.of(context).pop();
                    setState(() {
                      
                    });
                  },
                   child: const Text('Add')
                  )
                ],
              )
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}