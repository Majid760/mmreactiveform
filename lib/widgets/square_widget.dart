import 'package:flutter/material.dart';

class SquareWidget extends StatelessWidget {
  final String? title;
  const SquareWidget({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.pinkAccent.shade200,
        ),
        child: Center(
          child: Text(
            title!,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ));
  }
}
