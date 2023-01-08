import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widgets/edpisode_widget.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  late SharedPreferences prefs;
  bool isLiked = false;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList("likedToons");
    if (likedToons != null) {
      if (likedToons.contains(widget.id) == true) {
        setState(() {
          isLiked = true;
        });
      } else {
        await prefs.setStringList("likedToons", []);
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    // 두 Data Fetch API 는 사용자가 클릭했을 때의 ID 가 필요하기 떄문에 StatefulWidget 이어야함
    webtoon = ApiService.getWebtoonById(widget.id);
    episodes = ApiService.getLatestWebtoonEpisodeById(widget.id);
    initPrefs();
  }

  void onFavoritePressed() async {
    final likedToons = prefs.getStringList("likedToons");
    if (likedToons != null) {
      if (isLiked) {
        likedToons.remove(widget.id);
      } else {
        likedToons.add(widget.id);
      }
      await prefs.setStringList("likedToons", likedToons);
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 2,
        actions: [
          IconButton(
              onPressed: onFavoritePressed,
              icon: Icon(isLiked
                  ? Icons.favorite_outlined
                  : Icons.favorite_outline_rounded))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    // Hero Widget 을 사용해서 두 화면 사이에 이미지가 움직이는 것처럼 Animation을 줌 - tag 로 매칭됌
                    tag: widget.id,
                    child: Container(
                      width: 250,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15,
                            offset: const Offset(10, 10),
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                      child: Image.network(widget.thumb),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                future: webtoon,
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${snapshot.data!.genre} / ${snapshot.data!.age}',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        FutureBuilder(
                          future: episodes,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                // 랜더링해야할 데이터가 많지 않으므로 ListView 보다는..
                                children: [
                                  for (var episode in snapshot.data!)
                                    Episode(
                                        episode: episode, webtoonId: widget.id),
                                ],
                              );
                            }
                            return Container();
                          },
                        ),
                      ],
                    );
                  }
                  return const Text("...");
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
