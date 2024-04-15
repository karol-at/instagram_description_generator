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
                  return const Placeholder(
                    fallbackHeight: 100,
                    fallbackWidth: 100,)
                  ;
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