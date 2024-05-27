import 'package:flutter/material.dart';
import 'package:tpm_final_project/components/heading.dart';

class HomePage extends StatefulWidget {
  final Map<String, dynamic> data;
  const HomePage({super.key, required this.data});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String keyword = "";

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 20),
        Heading(
          text: "Hello, ${widget.data["name"]}  👋🏻",
          subtext: "Welcome to Armageddon.",
        ),
        // _mainmenu(context),
        const SizedBox(height: 16),
        _overview(context),
        const SizedBox(height: 20)
      ],
    );
  }

  Widget _overview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "Overview",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 23, 47, 39),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _cardOverview(
                context,
                icon: Icons.local_shipping,
                text: "5179",
                subtext: "Total Items",
                color: Colors.blue,
                subcolor: Colors.blue.shade50,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _cardOverview(
                context,
                icon: Icons.account_balance_wallet,
                text: "Rp12.560k",
                subtext: "Total Value",
                color: Colors.teal,
                subcolor: Colors.teal.shade50,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _cardOverview(
          context,
          icon: Icons.attach_money,
          text: "MacBook Pro M1",
          subtext: "Most Expensive Products",
          color: Colors.amber.shade700,
          subcolor: Colors.amber.shade50,
        ),
      ],
    );
  }

  Widget _cardOverview(
    BuildContext context, {
    IconData icon = Icons.flag,
    String text = "Lorem",
    String subtext = "Lorem Ipsum",
    Color color = Colors.black,
    Color subcolor = Colors.black12,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: subcolor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 28, color: color),
          ),
          const SizedBox(height: 20),
          Text(
            text,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtext,
            style: const TextStyle(
              fontSize: 14,
              color: Color.fromARGB(128, 0, 0, 0),
            ),
          ),
        ],
      ),
    );
  }
}