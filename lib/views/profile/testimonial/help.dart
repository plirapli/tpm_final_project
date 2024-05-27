import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:tpm_final_project/views/profile/testimonial/content.dart';

/// Main example page
class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  static const headerStyle = TextStyle(
    color: Color(0xffffffff),
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static const contentStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 246, 246),
      appBar: AppBar(title: const Text('Testimonial')),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Accordion(
          headerBackgroundColor: Colors.black,
          contentBackgroundColor: Colors.white,
          contentBorderColor: Colors.black,
          contentBorderWidth: 3,
          contentHorizontalPadding: 20,
          contentVerticalPadding: 20,
          scaleWhenAnimating: false,
          headerBorderRadius: 6,
          headerPadding: const EdgeInsets.all(18),
          sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
          sectionClosingHapticFeedback: SectionHapticFeedback.light,
          children: [
            AccordionSection(
              leftIcon: const Icon(Icons.rocket_launch, color: Colors.white),
              header: const Text('Kritik 🤔', style: headerStyle),
              content: const Column(children: [KritikContent()]),
            ),
            AccordionSection(
              leftIcon: const Icon(Icons.pin_outlined, color: Colors.white),
              header: const Text('Saran', style: headerStyle),
              content: const Column(
                children: [SaranContent()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
