import 'package:beegenius/screens/video_player_screen.dart';
import 'package:beegenius/youtube/src/model/youtube_video.dart';
import 'package:beegenius/youtube/youtube_api.dart';
import 'package:flutter/material.dart';
import '../theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static String key = "AIzaSyAwHzDnQUvUXEcCjX-WQOdb1_nh-nRsxMk";
  static String channelId = "UCHl0eauyGSH4GDDYnFiccyQ";

  YoutubeAPI youtube = YoutubeAPI(key, type: "channel");
  List<YouTubeVideo> videoResult = [];

  Future<void> callAPI() async {
    videoResult = await youtube.channel(channelId);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    callAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.themeBackgroundColor,
      appBar: AppBar(
        title: Container(
          margin: const EdgeInsets.only(bottom: 15),
          width: 160,
          child: ThemeImages.logo,
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: videoResult
            .map((video) => GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoScreen(
                              name: video.title, id: video.id ?? ''))),
                  child: listItem(video),
                ))
            .toList(),
      ),
    );
  }

  Widget listItem(YouTubeVideo video) {
    return Card(
      child: Container(
        color: ThemeColors.themeColor,
        margin: const EdgeInsets.symmetric(vertical: 0.0),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Image.network(
                video.thumbnail.small.url ?? '',
                width: 120.0,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(video.title,
                      softWrap: true,
                      style: TextStyle(
                          fontSize: 18.0, color: ThemeColors.textColor)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
