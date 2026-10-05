import 'package:flutter/material.dart';
import 'package:workshop_flutter__4ei3/widgets/auth_widgets.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _requiredField(String? value, String label) =>
      value == null || value.trim().isEmpty ? '$label cannot be empty' : null;

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Profile updated.')));
    Navigator.of(context).pop();
  }

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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const ProfileAvatar(),
                const SizedBox(height: 48),
                AuthField(
                  hint: 'Current password',
                  obscureText: true,
                  validator: (value) =>
                      _requiredField(value, 'Current password'),
                ),
                const SizedBox(height: 18),
                AuthField(
                  hint: 'New password',
                  obscureText: true,
                  validator: (value) => _requiredField(value, 'New password'),
                ),
                const SizedBox(height: 18),
                AuthField(
                  hint: 'Address',
                  maxLines: 3,
                  validator: (value) => _requiredField(value, 'Address'),
                ),
                const SizedBox(height: 24),
                AuthButton(label: 'SAVE', onPressed: _save),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
