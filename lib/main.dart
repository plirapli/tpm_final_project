import 'package:flutter/material.dart';
import 'package:tpm_final_project/auth/session.dart';
import 'package:tpm_final_project/theme.dart';
import 'package:tpm_final_project/views/app.dart';
import 'package:tpm_final_project/views/auth/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Armageddon',
      theme: MyTheme.myTheme(),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<String?>(
        future: SessionManager.getCredential(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            String? token = snapshot.data;
            if (token != null) {
              return AppPage(token: token);
            } else {
              return const LoginPage();
            }
          }
        },
      ),
    );
  }
}
