

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';

class PlayVideo extends StatefulWidget {
  final String url;
  const PlayVideo({super.key, required this.url});

  @override
  State<PlayVideo> createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  late VideoPlayerController _controller;
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
                    child: VideoPlayer(_controller),
                  ),
                  Positioned(
                    top: _controller.value.aspectRatio / 2,
                    bottom: _controller.value.aspectRatio / 2,
                    left: _controller.value.aspectRatio /2,
                    right: _controller.value.aspectRatio/ 2,
                    child: IconButton(
                        onPressed: (){
                          print(isPlaying);
                          if(isPlaying == true)
                            {
                              _controller.pause();
                              setState(() {
                                isPlaying = false;
                              });
                            }
                          else {
                            _controller.play();
                            setState(() {
                              isPlaying = true;
                            });
                          }
                        },
                        icon:Icon(isPlaying == true ? Icons.play_arrow : Icons.pause,color: Colors.white,size: 0.1.mediaW(context),)
                    ),
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
