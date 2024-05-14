library tags_page;

import 'package:flutter/material.dart';
import 'package:instagram_description_generator/Utils/appstate.dart';
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
                itemBuilder: (context, index) => TagElement(index: index, context: context,)
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

class TagElement extends StatelessWidget {
  TagElement({super.key, required this.index, required this.context});
  final int index;
  final BuildContext context;
  final MenuController controller = MenuController();


  @override
  Widget build(BuildContext context) {
    final Color uncheckedColor = Theme.of(context).colorScheme.secondary;
    final Color checkedColor = Theme.of(context).colorScheme.primary;
    return ListTile(
      title: Consumer<MyAppState>(
        builder: (context, state, child) => GestureDetector(
          onTap: (){
            final element = state.dataHandler.tagsList[index];
            if (state.descriptionCreator.tags.contains(element)) {
              state.descriptionCreator.tags.remove(element);
            } else {
              state.descriptionCreator.tags.add(element);
            }
            state.rerender();
          },
          onLongPress: () => controller.open(),
          child: MenuAnchor(
            menuChildren: [
              MenuItemButton(
                child: const Text('Remove'), 
                onPressed: () {
                  state.dataHandler.tagsList.removeAt(index);
                  state.dataHandler.saveTagsList();
                  state.rerender();
                },
              ),
            ],
            controller: controller,
            child: state.descriptionCreator.tags.contains(state.dataHandler.tagsList[index]) ?  Container(
              decoration: BoxDecoration(
                border: Border.all(color: checkedColor, width: 3),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('@${state.dataHandler.tagsList[index].tag}', style: TextStyle(color: checkedColor, fontSize: 20, fontWeight: FontWeight.w500),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Icon(Icons.check, color: checkedColor,)],
                  ),
                ],
              ),
            )
            : Container(
              decoration: BoxDecoration(
                border: Border.all(color: uncheckedColor.withOpacity(0.3), width: 3),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Text('@${state.dataHandler.tagsList[index].tag}', style: TextStyle(color: uncheckedColor, fontSize: 20, fontWeight: FontWeight.w500),),
                  
                  
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}