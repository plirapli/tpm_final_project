import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tpm_final_project/auth/api.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isError = false;
  String msg = "";
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Future<void> _registerUser(BuildContext context) async {
    try {
      final response = await Auth.register(
        _fullName.text,
        _username.text,
        _password.text,
      );
      final status = response["status"];
      msg = response["message"];

      if (status == "Success") {
        if (!context.mounted) return;
        Navigator.pop(context, msg);
      } else {
        throw Exception(msg);
      }
    } catch (e) {
      setState(() => isError = true);
      SnackBar snackBar = SnackBar(content: Text(e.toString()));
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  @override
  void dispose() {
    _fullName.dispose();
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
            _nameField(),
            _usernameField(),
            _passwordField(),
            _registerButton(context),
            const Divider(),
            _loginButton(context),
            const SizedBox(height: 20)
          ]),
        ),
      ),
    );
  }

  Widget _heading() {
    return Container(
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.1, bottom: 4),
        alignment: Alignment.centerLeft,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Register Page",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              "Please enter your credentials.",
              // style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }

  Widget _nameField() {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      child: TextFormField(
        enabled: true,
        controller: _fullName,
        onChanged: (value) {
          setState(() {
            if (isError == true) isError = false;
          });
        },
        decoration: InputDecoration(
            hintText: 'Enter your full name',
            prefixIcon: Icon(
              Icons.assignment_ind_rounded,
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
                        : Theme.of(context).colorScheme.error)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: (!isError)
                        ? Colors.transparent
                        : Theme.of(context).colorScheme.error))),
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
          hintText: 'Enter your username',
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
          hintText: 'Enter your password',
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

  Widget _registerButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 14, bottom: 6),
      width: MediaQuery.of(context).size.width,
      child: TextButton(
        onPressed: () => _registerUser(context),
        child: const Text('Register'),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Already have an account?",
          ),
          Container(
            margin: const EdgeInsets.only(top: 6),
            child: SizedBox(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black12,
                  foregroundColor: Colors.black,
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Login'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
