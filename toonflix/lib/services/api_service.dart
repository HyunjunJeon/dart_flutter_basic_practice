import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  // 이 함수는 asynchronous 함수임을 선언 - await 을 사용하기 위해서는 필수
  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> result = [];
    final todayUrl = Uri.parse('$baseUrl/$today');
    final response = await http.get(todayUrl); // 데이터가 올 때 까지 잠시 기다리게끔 await

    if (response.statusCode == 200) {
      final List<dynamic> todayWebtoons = jsonDecode(response.body);
      for (var webtoon in todayWebtoons) {
        result.add(WebtoonModel.fromJson(webtoon));
      }
      return result;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getWebtoonById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return WebtoonDetailModel.fromJson(jsonDecode(response.body));
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestWebtoonEpisodeById(
      String id) async {
    List<WebtoonEpisodeModel> result = [];
    final url = Uri.parse('$baseUrl/$id/episodes');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        result.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return result;
    }
    throw Error();
  }
}
