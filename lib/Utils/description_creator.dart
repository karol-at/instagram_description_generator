library description_creator;

import 'package:instagram_description_generator/Utils/list_loader.dart';


class Description {
  String title;
  String camera;
  String lens;
  List<Tag> tags;
  List<String> hashtags;

  Description({required this.title, required this.camera, required this.lens, required this.tags, required this.hashtags});

  String getFullDescription() {
    String output = '$title\n\n';
    output += '$camera + $lens\n\n';
    for(String hashtag in hashtags) {
      output += '#$hashtag ';
    }
    output += '\n\n';
    for(Tag tag in tags) {
      output += '@${tag.tag} | #${tag.hashtag}\n';
    }
    return output;
  }
}