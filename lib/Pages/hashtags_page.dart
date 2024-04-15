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
      builder: (context, data, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Hashtags'),
        ),
        body: Column(
          children: [
            
            Expanded(
              child: ListView.builder(
                itemCount: data.dataHandler.categoryList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: Text(data.dataHandler.categoryList[index], style: Theme.of(context).textTheme.titleMedium,)
                          ),
                        Wrap(
                          children: [
                            for (String hashtag in data.dataHandler.hashtagList[index])
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
                    if (!data.dataHandler.categoryList.contains(categoryController.text)) {
                      data.dataHandler.categoryList.add(categoryController.text);
                      data.dataHandler.saveList(data.dataHandler.categoryList, 'categoryList');
                      data.dataHandler.hashtagList.add([]);
                    }
                    int index = data.dataHandler.categoryList.indexOf(categoryController.text);
                    if (!data.dataHandler.hashtagList[index].contains(hashtagController.text)) {
                      data.dataHandler.hashtagList[index].add(hashtagController.text);
                    }
                    data.dataHandler.saveList(data.dataHandler.hashtagList[index], data.dataHandler.categoryList[index]);
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