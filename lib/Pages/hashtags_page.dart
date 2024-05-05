library hashtags_page;

import 'package:flutter/material.dart';
import 'package:instagram_description_generator/Utils/appstate.dart';
import 'package:instagram_description_generator/fonts/iconic_icons.dart';
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
                  return Stack(
                    children: [
                      Card(
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
                                  HashtagBox(hashtag: hashtag, index: index),
                              ],
                            ),
                          ],
                        )
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              showDialog(context: context, builder: (context) => SimpleDialog(
                                title: const Text('Add a new hashtag'),
                                contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                                children: [
                                  TextField(
                                    decoration: const InputDecoration(
                                      hintText: 'Hashtag',
                                      prefix: SizedBox(width: 10, child: Text('#')),
                                    ),
                                    controller: hashtagController,
                                  ),
                                  TextButton(
                                    onPressed: (){
                                      if (hashtagController.text.isEmpty) {
                                        return;
                                      }
                                      if (!state.dataHandler.hashtagList[index].contains(hashtagController.text)) {
                                        state.dataHandler.hashtagList[index].add(hashtagController.text);
                                        state.dataHandler.saveList(state.dataHandler.hashtagList[index], state.dataHandler.categoryList[index]);
                                      }
                                      Navigator.of(context).pop();
                                      setState(() {
                                      
                                      });
                                    }, 
                                    child: const Text('Add')
                                  ),
                                ],
                              ));
                            },
                          ),
                        ),
                      ),
                    ],
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
                  decoration: const InputDecoration(
                    hintText: 'New category',
                    prefix: SizedBox(width: 10),
                  ),
                  controller: categoryController,
                ), 
                TextButton(onPressed: (){
                  //TODO: Make it imposisble to add empty categories
                  if (categoryController.text.isEmpty) {
                    return;
                  }
                  if (!state.dataHandler.categoryList.contains(categoryController.text)) {
                    state.dataHandler.categoryList.add(categoryController.text);
                    state.dataHandler.saveList(state.dataHandler.categoryList, 'categoryList');
                    state.dataHandler.hashtagList.add([]);
                  }
                  categoryController.clear();
                  Navigator.of(context).pop();
                  setState(() {
                    
                  });
                },
                  child: const Text('Add')
                )
                ],
              ));
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
    required this.index,
  });

  final String hashtag;
  final int index;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<MyAppState>(
      builder: (context, state, child) => Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          //TODO: Make the delete button correct size, make these things wrap again (with a container around them?)
          children: [
            FilledButton(
              style: FilledButton.styleFrom(
                //TODO: Figure out how to make nice colors
                backgroundColor: theme.brightness == Brightness.light ?
                state.descriptionCreator.hashtags.contains(hashtag) ? theme.colorScheme.tertiaryContainer : theme.colorScheme.primaryContainer
                : 
                state.descriptionCreator.hashtags.contains(hashtag) ? theme.colorScheme.primaryContainer : theme.colorScheme.tertiaryContainer,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20),
                    right: Radius.circular(0),
                  ),
                ),
              ),
              onPressed: (){
                state.checkHahstag(hashtag);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('#$hashtag'),
              ),
            ),
            FilledButton(
              onPressed: (){
                state.dataHandler.hashtagList[index].remove(hashtag);
                state.dataHandler.saveList(state.dataHandler.hashtagList[index], state.dataHandler.categoryList[index]);
                state.descriptionCreator.hashtags.remove(hashtag);
                if (state.dataHandler.hashtagList[index].isEmpty) {
                  state.dataHandler.categoryList.removeAt(index);
                  state.dataHandler.hashtagList.removeAt(index);
                  state.dataHandler.saveList(state.dataHandler.categoryList, 'categoryList');
                }
                state.rerender();
              },
              style: FilledButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(0),
                    right: Radius.circular(20),
                  ),
                ),
                backgroundColor: theme.colorScheme.error,
                foregroundColor: theme.colorScheme.onError,
              ),
            child: const Icon(IconicIcons.trash),)
          ],
        ),
      ),
    );
  }
}