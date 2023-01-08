class WebtoonEpisodeModel {
  final String id, title, rating, date;

  // named constructor
  WebtoonEpisodeModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        rating = json['rating'],
        date = json['date'];
}
