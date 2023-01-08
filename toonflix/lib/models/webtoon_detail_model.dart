class WebtoonDetailModel {
  final String title, about, genre, age;

  // named constructor
  WebtoonDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        about = json['about'],
        genre = json['genre'],
        age = json['age'];
}
