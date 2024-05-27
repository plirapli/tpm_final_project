import 'package:flutter/material.dart';
import 'package:tpm_final_project/auth/session.dart';
import 'package:tpm_final_project/views/auth/login.dart';
import 'package:tpm_final_project/views/testimonial/help.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> data;
  const ProfilePage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 12),
        const SizedBox(height: 128, child: Icon(Icons.person, size: 128)),
        const SizedBox(height: 12),
        Text(
          data["name"],
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text("@${data["username"]}", style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () => _helpHandler(context),
          child: const Text("Testimonial"),
        ),
        const SizedBox(height: 4),
        TextButton(
          onPressed: () => _aboutHandler(context),
          child: const Text("About Us"),
        ),
        const SizedBox(height: 4),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.black12,
            foregroundColor: Colors.black,
          ),
          onPressed: () => _logoutHandler(context),
          child: const Text("Logout"),
        ),
        const SizedBox(height: 20)
      ],
    );
  }

  void _helpHandler(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HelpPage()),
    );
  }

  void _aboutHandler(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HelpPage()),
    );
  }

  void _logoutHandler(BuildContext context) async {
    await SessionManager.logout();
    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return const LoginPage();
      }),
    );
  }
}
