import 'dart:typed_data';

import 'package:app/main.dart';
import 'package:app/screens/signin.dart';
import 'package:app/services/user_service.dart';
import 'package:app/widgets/circle_image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignedInProfilePage extends StatefulWidget {
  const SignedInProfilePage({
    super.key,
  });

  @override
  State<SignedInProfilePage> createState() =>
      _SignedInProfileSettingsPageState();
}

class _SignedInProfileSettingsPageState extends State<SignedInProfilePage> {
  final TextEditingController _firstnameController = TextEditingController();

  Uint8List? _image;

  @override
  void initState() {
    setState(() {
      _firstnameController.text = UserService.instance.currentUser!.name;
    });
    super.initState();
  }

  void _updateImage(Uint8List newImage) async {
    _image = newImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Profile Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 30),
        child: Column(
          children: [
            CircleImagePicker(
              onSelect: _updateImage,
              radius: 70,
              initialImage: NetworkImage(
                "https://pbs.twimg.com/media/EfuLzliXsAAhi52.jpg",
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("35 Donations • 117 Pts"),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _firstnameController,
                    decoration: InputDecoration(
                      labelText: "First name",
                      labelStyle: const TextStyle(
                        fontSize: 22,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ],
              ),
            ),
            FilledButton(
              onPressed: () {
                UserService.instance.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage(),
                  ),
                );
              },
              child: Row(children: [
                Expanded(child: Container()),
                const Text("Sign Out"),
                Expanded(child: Container())
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
