library hashtags_page;

import 'package:flutter/material.dart';
import 'package:instagram_description_generator/Utils/appstate.dart';
import 'package:provider/provider.dart';

class HashtagsPage extends StatefulWidget {
  const HashtagsPage({super.key});

  @override
  State<HashtagsPage> createState() => _HashtagsPageState();
}

class _HashtagsPageState extends State<HashtagsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(
      builder: (context, data, child) => const Placeholder()
      );
  }
}