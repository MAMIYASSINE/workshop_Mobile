import 'package:flutter/material.dart';
import 'package:workshop_flutter__4ei3/widgets/auth_widgets.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: authPageColor,
      appBar: AppBar(
        backgroundColor: authPageColor,
        title: const Text('Profile settings'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ProfileAvatar(),
              const SizedBox(height: 48),
              const AuthField(hint: 'Current password', obscureText: true),
              const SizedBox(height: 18),
              const AuthField(hint: 'New password', obscureText: true),
              const SizedBox(height: 18),
              const AuthField(hint: 'Address', maxLines: 3),
              const SizedBox(height: 24),
              AuthButton(label: 'SAVE', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}