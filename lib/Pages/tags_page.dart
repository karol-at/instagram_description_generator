library tags_page;

import 'package:flutter/material.dart';
import 'package:instagram_description_generator/Utils/list_loader.dart';
import 'package:instagram_description_generator/fonts/iconic_icons.dart';

class TagsPage extends StatefulWidget {
  final ThemeData theme;
  final DataHandler dataHandler;

  const TagsPage({super.key, required this.theme, required this.dataHandler});

  @override
  State<TagsPage> createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {

  TextEditingController tagController = TextEditingController();
  TextEditingController relatedHashtagController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        prefix: Text('@'),
                      ),
                      controller: tagController,
                      onEditingComplete: addTag,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Add a related hashtag',
                        prefix: Text('#'),
                      ),
                      controller: relatedHashtagController,
                      onEditingComplete: addTag,
                    ),
                    
                  ],
                ),
              ),
              SizedBox(
                width: 50,
                child: IconButton(
                  onPressed: addTag,
                  icon: const Icon(IconicIcons.plus),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.dataHandler.tagsList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Expanded(child: Text('@${widget.dataHandler.tagsList[index].tag}')),
                      Container(
                        decoration: BoxDecoration(
                          color: widget.theme.colorScheme.primary,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(IconicIcons.trash),
                              onPressed: (){
                                widget.dataHandler.tagsList.removeAt(index);
                                widget.dataHandler.saveTagsList();
                                setState(() {                          
                                });
                              },
                            ),
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
    );
  }

  void addTag() {
                  widget.dataHandler.tagsList.add(Tag(
                    tag: tagController.text,
                      hashtag: relatedHashtagController.text,
                    ));
                    tagController.clear();
                    relatedHashtagController.clear();
                    widget.dataHandler.saveTagsList();
                    setState(() {                          
                    });
                  }
}