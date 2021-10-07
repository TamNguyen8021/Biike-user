import 'package:bikes_user/app/ui/android/pages/on_board/on_board/on_board.dart';
import 'package:flutter/material.dart';

class DotsWidget extends StatelessWidget {
  const DotsWidget({
    Key? key,
    required this.listOnBoard,
    required this.indexState,
  }) : super(key: key);

  final List<OnBoardItems> listOnBoard;
  final int indexState;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: listOnBoard.asMap().entries.map((entry) {
        return Container(
          width: 12.0,
          height: 12.0,
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: indexState == entry.key ? Colors.white : Colors.black,
          ),
        );
      }).toList(),
    );
  }
}
