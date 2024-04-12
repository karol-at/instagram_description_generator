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
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}