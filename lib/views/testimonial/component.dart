import 'package:flutter/material.dart';

class ComponentHelp extends StatelessWidget {
  final List<String> textList;

  const ComponentHelp({super.key, required this.textList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: textList.map((text) => _text(text)).toList(),
    );
  }

  Widget _text(String text) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }
}
