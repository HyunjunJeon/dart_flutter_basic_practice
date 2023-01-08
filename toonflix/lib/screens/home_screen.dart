import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "어늘의 웹툰",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 2,
      ),
      body: FutureBuilder(
        // StateFulWidget 을 사용할 필요가 없음
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // return ListView( // 기본적으로 모든 데이터를 로드하기때문에 메모리를 많이 사용할 것
            //   children: [
            //     for (var webtoon in snapshot.data!) Text(webtoon.title),
            //   ],
            // );
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(child: makeList(snapshot)),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      // temBuilder 함수를 실행해서 만들어야하는 아이템의 index를 받음(itemCount 까지 만드는 것)
      // 필요할 때마다 적절한 개수만 만드니, 메모리를 아낄 수 있음
      itemBuilder: (context, index) {
        final webtoon = snapshot.data![index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      // 아이템 사이사이에 어떤 구분자를 넣어줄 지
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
    );
  }
}
