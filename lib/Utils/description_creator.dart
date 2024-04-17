library description_creator;

import 'package:instagram_description_generator/Utils/list_loader.dart';


class Description {
  String title;
  String camera;
  String lens;
  List<Tag> tags;
  List<String> hashtags;
  String description = '';

  Description({required this.title, required this.camera, required this.lens, required this.tags, required this.hashtags});

  void createDescription() {
    description = '$title\n\n';
    description += '$camera + $lens\n\n';
    for(String hashtag in hashtags) {
      description += '#$hashtag ';
    }
    description += '\n\n';
    for(Tag tag in tags) {
      description += '@${tag.tag} | #${tag.hashtag}\n';
    }
  }
}