library tags_page;

import 'package:flutter/material.dart';
import 'package:instagram_description_generator/Utils/list_loader.dart';

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
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Add a related hashtag',
                        prefix: Text('#'),
                      ),
                      controller: relatedHashtagController,
                    ),
                    
                  ],
                ),
              ),
              SizedBox(
                width: 50,
                child: ElevatedButton(
                      onPressed: () {
                        widget.dataHandler.tagsList.add(Tag(
                          tag: tagController.text,
                          hashtag: relatedHashtagController.text,
                        ));
                        tagController.clear();
                        relatedHashtagController.clear();
                        widget.dataHandler.saveTagsList(widget.dataHandler.tagsList);
                        setState(() {
                          
                        });
                      },
                      child: const Text('Add'),
                    ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.dataHandler.tagsList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('@${widget.dataHandler.tagsList[index].tag}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}