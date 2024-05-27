import 'package:flutter/material.dart';
import 'package:tpm_final_project/views/profile/testimonial/component.dart';

class KritikContent extends StatelessWidget {
  const KritikContent({super.key});

  static const List<String> textList = [
    "Kegiatan perkuliahan yang dilakukan selama ini telah berjalan lancar.",
    "Menurut saya, waktu yang diberikan untuk mengerjakan tugas terlalu sedikit.",
  ];

  @override
  Widget build(BuildContext context) => const ComponentHelp(textList: textList);
}

class SaranContent extends StatelessWidget {
  const SaranContent({super.key});

  static const List<String> textList = [
    "Sebaiknya waktu untuk mengerjakan tugas lebih diperpanjang lagi.",
    "Sebaiknya UTS dan UAS diubah agar bersifat Open Book.",
  ];

  @override
  Widget build(BuildContext context) => const ComponentHelp(textList: textList);
}
