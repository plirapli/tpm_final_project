import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tpm_final_project/auth/session.dart';
import 'package:tpm_final_project/auth/api.dart';
import 'package:tpm_final_project/views/app.dart';
import 'package:tpm_final_project/views/auth/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String msg = "";
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isError = false;

  Future<void> _loginUser(BuildContext context) async {
    try {
      final response = await Auth.login(_username.text, _password.text);
      final status = response["status"];
      msg = response["message"];

      if (status == "Success") {
        final String data = response["token"];
        await SessionManager.setCredential(data);
        String? credential = await SessionManager.getCredential();
        if (!context.mounted) return;
        if (credential != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AppPage(token: credential)),
          );
        }
      } else {
        setState(() => isError = true);
      }
    } catch (e) {
      setState(() => isError = false);
      msg = "Can't connect to server.";
    } finally {
      if (context.mounted) {
        SnackBar snackBar = SnackBar(
          content: Text(msg),
          duration: Durations.long2,
        );
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    }
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(scrollDirection: Axis.vertical, children: [
            const SizedBox(height: 20),
            _heading(),
            _usernameField(),
            _passwordField(),
            _loginButton(context),
            const Divider(),
            _registerButton(context),
            const SizedBox(height: 20)
          ]),
        ),
      ),
    );
  }

  Widget _heading() {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.1,
        bottom: 4,
      ),
      alignment: Alignment.centerLeft,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Login Page",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text("Please enter your credentials."),
        ],
      ),
    );
  }

  Widget _usernameField() {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      child: TextFormField(
        enabled: true,
        controller: _username,
        onChanged: (value) {
          setState(() {
            if (isError) isError = false;
          });
        },
        decoration: InputDecoration(
          hintText: 'Username',
          prefixIcon: Icon(
            Icons.person,
            color: (!isError)
                ? Colors.black87
                : Theme.of(context).colorScheme.error,
          ),
          filled: true,
          fillColor: (isError)
              ? Theme.of(context).colorScheme.errorContainer
              : const Color.fromARGB(255, 229, 229, 229),
          contentPadding: const EdgeInsets.all(12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: (!isError)
                    ? Colors.transparent
                    : Theme.of(context).colorScheme.error),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: (!isError)
                    ? Colors.transparent
                    : Theme.of(context).colorScheme.error),
          ),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      child: TextFormField(
        enabled: true,
        controller: _password,
        onChanged: (value) {
          setState(() {
            if (isError) isError = false;
          });
        },
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Password',
          prefixIcon: Icon(
            Icons.key,
            color: (!isError)
                ? Colors.black87
                : Theme.of(context).colorScheme.error,
          ),
          filled: true,
          fillColor: (isError)
              ? Theme.of(context).colorScheme.errorContainer
              : const Color.fromARGB(255, 229, 229, 229),
          contentPadding: const EdgeInsets.all(12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: (!isError)
                    ? Colors.transparent
                    : Theme.of(context).colorScheme.error),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: (!isError)
                    ? Colors.transparent
                    : Theme.of(context).colorScheme.error),
          ),
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 14, bottom: 6),
      width: MediaQuery.of(context).size.width,
      child: TextButton(
        onPressed: () => _loginUser(context),
        child: const Text('Login'),
      ),
    );
  }

  Widget _registerButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text("Don't have an account?"),
          Container(
            margin: const EdgeInsets.only(top: 6),
            child: SizedBox(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black12,
                  foregroundColor: Colors.black,
                ),
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                  );

                  if (result != null) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(content: Text(result)));
                  }
                },
                child: const Text('Register'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
