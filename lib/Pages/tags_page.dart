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
      builder: (context, data, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Tags'),
        ),
        body: Column( 
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          hintText: 'Add a tag',
                          prefix: SizedBox(width: 15, child: Text('@')),
                        ),
                        controller: tagController,
                        onEditingComplete: (){data.dataHandler.addTag(tagController, relatedHashtagController); setState(() {});},
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          hintText: 'Add a related hashtag',
                          prefix: SizedBox(width: 15, child: Text('#')),
                        ),
                        controller: relatedHashtagController,
                        onEditingComplete: (){data.dataHandler.addTag(tagController, relatedHashtagController); setState(() {});}
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: IconButton(
                    onPressed: (){data.dataHandler.addTag(tagController, relatedHashtagController); setState(() {});},
                    icon: const Icon(IconicIcons.plus),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data.dataHandler.tagsList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      children: [
                        Expanded(child: Text('@${data.dataHandler.tagsList[index].tag}')),
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(IconicIcons.trash),
                                onPressed: (){
                                  data.dataHandler.tagsList.removeAt(index);
                                  data.dataHandler.saveTagsList();
                                  setState(() {                          
                                  });
                                },
                              ),
                              Checkbox(value: data.dataHandler.tagsList[index].selected,
                              onChanged: (bool? value) {                             
                                setState(() {
                                  data.dataHandler.tagsList[index].selected = value!;
                                });
                                }
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}