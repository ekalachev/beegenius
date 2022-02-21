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
      margin: const EdgeInsets.only(
        top: 3,
      ),
      child: Container(
          color: ThemeColors.themeColor,
          height: 255,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      video.thumbnail.high.url ?? '',
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 5, right: 5, top: 8),
                      child: Text(video.title,
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 16.0, color: ThemeColors.textColor)),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                      child: Text(video.description ?? '',
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 14.0,
                              color: ThemeColors.descriptionColor)),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
