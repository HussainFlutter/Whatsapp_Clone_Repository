
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayVideo extends StatefulWidget {
  final String url;
  const PlayVideo({super.key, required this.url});

  @override
  State<PlayVideo> createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  late VideoPlayerController _controller;
  late ChewieController chewieController;
  late Future<void> _initializeVideo;
  @override
  void initState() {
    super.initState();
     _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.url,),
    );
    _initializeVideo = _controller.initialize().then((value) {
      _controller.play();
      setState(() {

      });
    });
    chewieController = ChewieController(
        videoPlayerController: _controller
    );
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  bool isPlaying = true;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initializeVideo,
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.done)
            {
              return Stack(
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: Chewie(controller: chewieController),
                  ),
                ],
              );
            }
          else {
            return const CircularProgressIndicator();
          }
        }
    );
  }
}
