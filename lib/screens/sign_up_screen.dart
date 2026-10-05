import 'package:flutter/material.dart';
import 'package:workshop_flutter__4ei3/screens/store_home_screen.dart';
import 'package:workshop_flutter__4ei3/widgets/auth_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _validateUsername(String? value) =>
      value == null || value.trim().length < 3 ? 'Username invalide' : null;

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      return 'Email invalide';
    }
    return null;
  }

  String? _validatePassword(String? value) =>
      value == null || value.length < 6 ? 'Password invalide' : null;

  void _signUp() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const StoreHomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: authPageColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const MovieLogo(),
                const SizedBox(height: 38),
                const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 22),
                AuthField(hint: 'username', validator: _validateUsername),
                const SizedBox(height: 18),
                AuthField(
                  hint: 'email',
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 18),
                AuthField(
                  hint: 'password',
                  obscureText: true,
                  validator: _validatePassword,
                ),
                const SizedBox(height: 24),
                ArrowPrompt(
                  label: 'Already have an account?',
                  onTap: () => Navigator.of(context).pop(),
                ),
                const SizedBox(height: 24),
                AuthButton(label: 'SIGN UP', onPressed: _signUp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
