import 'package:flutter/material.dart';
import 'package:toonflix/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;

  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 탭, 마우스 이동, 드래그, 줌 등의 제스처를 감지함
      onTap: () {
        // 애니메이션 효과를 이용해서 다른 페이지로 이동한 것 처럼 현재 화면 위로 올려줌
        Navigator.push(
          context,
          // Stateless Widget 을 스크린처럼 보이게
          MaterialPageRoute(
            builder: ((context) =>
                DetailScreen(title: title, thumb: thumb, id: id)),
            fullscreenDialog: true, // 이미지가 바닥에서 올라오고, X 표시로 없어지게 됌
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            // Hero Widget 을 사용해서 두 화면 사이에 이미지가 움직이는 것처럼 Animation을 줌 - tag 로 매칭됌
            tag: id,
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
              child: Image.network(thumb),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
