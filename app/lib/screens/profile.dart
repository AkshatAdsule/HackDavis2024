import 'dart:typed_data';

import 'package:app/screens/signed_in_profile.dart';
import 'package:app/screens/signed_out_profile.dart';
import 'package:app/screens/signin.dart';
import 'package:app/widgets/circle_image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({
    super.key,
  });

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  Widget? content;

  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser == null) {
      setState(() {
        content = SignedOutProfilePage();
      });
    } else {
      setState(() {
        content = SignedInProfilePage();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return content == null ? const CircularProgressIndicator() : content!;
  }
}
