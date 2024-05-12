library tags_page;

import 'package:flutter/material.dart';
import 'package:instagram_description_generator/Utils/appstate.dart';
import 'package:instagram_description_generator/fonts/iconic_icons.dart';
import 'package:provider/provider.dart';

class TagsPage extends StatefulWidget {
  const TagsPage({super.key,});

  @override
  State<TagsPage> createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {

  TextEditingController tagController = TextEditingController();
  TextEditingController relatedHashtagController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(
      builder: (context, state, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Tags'),
        ),
        body: Column( 
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: state.dataHandler.tagsList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      children: [
                        Expanded(child: Text('@${state.dataHandler.tagsList[index].tag} | #${state.dataHandler.tagsList[index].hashtag}'),),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                                color: state.themeData.colorScheme.errorContainer,
                              ),
                              height: 40,
                              child: IconButton(
                                icon: const Icon(IconicIcons.trash),
                                color: state.themeData.colorScheme.onErrorContainer,
                                onPressed: () {
                                  state.dataHandler.tagsList.removeAt(index);
                                  state.dataHandler.saveTagsList();
                                  setState(() {});
                                },
                              ),
                            ),
                            Container(
                              //TODO: figure out nice selection icons withouth the checkbox
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                color: state.themeData.colorScheme.primaryContainer,
                              ),
                              height: 40,
                              child: Checkbox(value: state.dataHandler.tagsList[index].selected,
                                onChanged: (bool? value) {                             
                                  setState(() {
                                    state.dataHandler.tagsList[index].selected = value!;
                                    state.descriptionCreator.tags.contains(state.dataHandler.tagsList[index]) ?
                                    state.descriptionCreator.tags.remove(state.dataHandler.tagsList[index]) :
                                    state.descriptionCreator.tags.add(state.dataHandler.tagsList[index]);
                                  });
                                }
                              ),
                            )
                          ],
                        )
                      ],
                    ),
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
                          hintText: 'Add a tag',
                          prefix: SizedBox(width: 15, child: Text('@')),
                        ),
                        controller: tagController,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          hintText: 'Add a related hashtag',
                          prefix: SizedBox(width: 15, child: Text('#')),
                        ),
                        controller: relatedHashtagController,
                      ),
                  TextButton(onPressed: (){
                    
                    Navigator.of(context).pop();
                    setState(() {
                      state.dataHandler.addTag(tagController, relatedHashtagController);
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