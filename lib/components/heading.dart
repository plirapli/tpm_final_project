import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String text, subtext;

  const Heading({super.key, required this.text, required this.subtext});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 23, 47, 39)),
          ),
          Text(
            subtext,
            style: const TextStyle(
              fontSize: 16,
              color: Color.fromARGB(150, 0, 0, 0),
            ),
          ),
        ],
      ),
    );
  }
}
