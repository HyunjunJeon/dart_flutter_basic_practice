class WebtoonModel {
  final String title, thumb, id;

  // named constructor
  // 일반적으로 생성자를 만들고 할당하는 방식으로도 사용은 가능하지만, dart-flutter 권장은 아님
  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
