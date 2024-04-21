library hashtags_page;

import 'package:flutter/material.dart';
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
  bool addNewCategory = true;

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
                  return Card(
                    margin: const EdgeInsets.all(10),
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
                              HashtagBox(hashtag: hashtag),
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
                  DropdownButton<String>(
                    hint: const Text('Select a category'),
                    items: state.dataHandler.categoryList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList() + const [
                      DropdownMenuItem<String>(
                        value: 'New category',
                        child: Text('New category'),
                      ),
                    ],
                    onChanged: (String? value) {
                      addNewCategory = value == 'New category' ? true : false;
                      setState(() {});
                    },
                  ),
                  //TODO: figure out why this doesn't work
                  addNewCategory ? TextField(
                    decoration: const InputDecoration(
                      hintText: 'New category',
                      prefix: SizedBox(width: 15),
                    ),
                    controller: categoryController,
                  ) : const SizedBox(),
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

class HashtagBox extends StatelessWidget {
  const HashtagBox({
    super.key,
    required this.hashtag,
  });

  final String hashtag;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<MyAppState>(
      builder: (context, state, child) => Padding(
        padding: const EdgeInsets.all(5),
        child: ElevatedButton(
          //TODO: add remove buttton
          style: ElevatedButton.styleFrom(
            backgroundColor: state.descriptionCreator.hashtags.contains(hashtag) ? theme.colorScheme.secondaryContainer : theme.colorScheme.primaryContainer,
          ),
          onPressed: (){
            state.checkHahstag(hashtag);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('#$hashtag'),
          ),
        ),
      ),
    );
  }
}