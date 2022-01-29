import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../theme.dart';

class VideoScreen extends StatefulWidget {
  final String name, id;

  VideoScreen({required this.name, required this.id});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController _controller;
  late bool _hideAppBar;

  @override
  void initState() {
    super.initState();
    _hideAppBar = false;
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: false,
          enableCaption: false,
          useHybridComposition: false,
          loop: true,
          forceHD: true),
    )..addListener(_listener);
  }

  void _listener() {
    if (_controller.value.isPlaying && !_hideAppBar) {
      setState(() {
        _hideAppBar = true;
        if (MediaQuery.of(context).orientation == Orientation.portrait) {
          _controller.toggleFullScreenMode();
        }
      });
    } else if (!_controller.value.isPlaying && _hideAppBar) {
      setState(() {
        _hideAppBar = false;
        if (MediaQuery.of(context).orientation == Orientation.landscape) {
          _controller.toggleFullScreenMode();
        }
      });
    }
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.themeBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: ThemeColors.textColor),
        backgroundColor: ThemeColors.themeColor,
        title:
            Text(widget.name, style: TextStyle(color: ThemeColors.textColor)),
        toolbarHeight: _hideAppBar ? 0.0 : 60.0,
      ),
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        liveUIColor: ThemeColors.themeColor,
        progressIndicatorColor: ThemeColors.themeColor,
        progressColors: ProgressBarColors(
            backgroundColor: Colors.yellow,
            bufferedColor: ThemeColors.textColor),
        onReady: () {},
      ),
    );
  }
}
