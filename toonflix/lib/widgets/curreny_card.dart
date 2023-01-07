import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  final String name, code, amount;
  final IconData icon;
  final bool isInverted;
  final double order;

  final _overflowScale = -20;
  final _blackColor = const Color(0xFF1F2123);

  const CurrencyCard({
    super.key,
    required this.name,
    required this.code,
    required this.amount,
    required this.icon,
    required this.isInverted,
    required this.order,
  });

  @override
  Widget build(Object context) {
    return Transform.translate(
      offset: Offset(0, _overflowScale * order),
      child: Container(
        clipBehavior: Clip.hardEdge, // 이 컨테이너를 벗어나는 것이 생기면 짤라버리는 것
        decoration: BoxDecoration(
          color: isInverted ? Colors.white : _blackColor,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: isInverted ? _blackColor : Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        amount,
                        style: TextStyle(
                          color: isInverted ? Colors.black : Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        code,
                        style: TextStyle(
                          color: isInverted
                              ? Colors.black.withOpacity(0.8)
                              : Colors.white.withOpacity(0.8),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Transform.scale(
                // 카드의 크기는 변화시키지 않고 아이콘만 크기를 조절하기 위해서
                scale: 2.2,
                child: Transform.translate(
                  // 아이콘의 위치를 조절하기 위해서
                  offset: const Offset(-5, 17),
                  child: Icon(
                    icon,
                    color: isInverted ? Colors.black : Colors.white,
                    size: 90,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
