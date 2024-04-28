import 'package:app/main.dart';
import 'package:app/screens/home.dart';
import 'package:app/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbauth;

class SignedOutProfilePage extends StatefulWidget {
  const SignedOutProfilePage({super.key});

  @override
  State<SignedOutProfilePage> createState() => _SignedOutProfilePageState();
}

class _SignedOutProfilePageState extends State<SignedOutProfilePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text("Sign in to contribute to the community",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 10),
          TextField(
            controller: emailController,
            autofillHints: const [AutofillHints.email],
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
                hintText: "Name", border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: passwordController,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            decoration: const InputDecoration(
              hintText: "Password",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              // Sign in
              await UserService.instance.createAccountWithEmailAndPassword(
                  emailController.text,
                  passwordController.text,
                  nameController.text);
              if (mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage(),
                  ),
                );
              }
            },
            child: const Text("Sign in"),
          ),
        ],
      ),
    );
  }
}
