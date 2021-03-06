import 'package:bikes_user/app/ui/android/pages/on_board/on_board/on_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemOnBoardWidget extends StatelessWidget {
  const ItemOnBoardWidget({
    Key? key,
    required this.itemOnBoard,
  }) : super(key: key);

  final OnBoardItems itemOnBoard;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.asset(
            itemOnBoard.pathImage,
            width: 300,
            height: 300,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            itemOnBoard.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.sp,
            ),
          ),
        ),
        SizedBox(
          width: 350,
          child: Text(
            itemOnBoard.des,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
            ),
          ),
        ),
      ],
    );
  }
}
