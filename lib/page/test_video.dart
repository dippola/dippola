import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import 'package:appinio_video_player/appinio_video_player.dart';

class TestVideo extends StatefulWidget {
  const TestVideo({super.key});

  @override
  State<TestVideo> createState() => _TestVideoState();
}

class _TestVideoState extends State<TestVideo> {

  late CustomVideoPlayerWebController _customVideoPlayerWebController;
  final CustomVideoPlayerWebSettings _customVideoPlayerWebSettings = CustomVideoPlayerWebSettings(src: "https://firebasestorage.googleapis.com/v0/b/dippola-web.appspot.com/o/20240706_195719.mp4?alt=media&token=2468cb3a-f97a-4174-824a-549bbb2feb6a");

  @override
  void initState() {
    super.initState();

    _customVideoPlayerWebController = CustomVideoPlayerWebController(webVideoPlayerSettings: _customVideoPlayerWebSettings);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: CupertinoPageScaffold(
          child: SafeArea(
            child: CustomVideoPlayerWeb(customVideoPlayerWebController: _customVideoPlayerWebController),
          ),
        ),
      ),
    );
  }
}
