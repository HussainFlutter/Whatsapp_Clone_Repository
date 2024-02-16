


import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

import '../../domain/entity/custom_story_entity.dart';
import '../../domain/entity/status_entity.dart';

class ViewStoryPage extends StatefulWidget {
  final List<CustomStoryEntity> stories;
  const ViewStoryPage({super.key, required this.stories});

  @override
  State<ViewStoryPage> createState() => _ViewStoryPageState();
}

class _ViewStoryPageState extends State<ViewStoryPage> {
  final StoryController controller = StoryController();
  @override
  Widget build(BuildContext context) {
    return StoryView(
      onComplete: (){
        Navigator.pop(context);
      },
      controller: controller,
      storyItems: widget.stories.map((e)
      {
        if(e.type == StatusType.image.toString())
          {
             return StoryItem.inlineImage(url: e.url!, controller: controller);
          }
        else if (e.type == StatusType.video.toString())
          {
            return StoryItem.pageVideo(e.url!, controller: controller);
          }
      }).toList(),
    );
  }
}
