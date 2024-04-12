library hashtags_page;

import 'package:flutter/material.dart';
import 'package:instagram_description_generator/Utils/list_loader.dart';

class HashtagsPage extends StatefulWidget {
  final ThemeData theme;
  final DataHandler dataHandler;
  const HashtagsPage({super.key, required this.theme, required this.dataHandler});

  @override
  State<HashtagsPage> createState() => _HashtagsPageState();
}

class _HashtagsPageState extends State<HashtagsPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}