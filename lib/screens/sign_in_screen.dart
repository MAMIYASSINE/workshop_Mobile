import 'package:flutter/material.dart';
import 'package:workshop_flutter__4ei3/widgets/auth_widgets.dart';
import 'package:workshop_flutter__4ei3/screens/forgot_password_screen.dart';
import 'package:workshop_flutter__4ei3/screens/sign_up_screen.dart';
import 'package:workshop_flutter__4ei3/screens/store_home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty ||
        !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      return 'Email invalide';
    }
    return null;
  }

  void _signIn() {
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
                  'Sign In',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 22),
                AuthField(
                  hint: 'email',
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 18),
                const AuthField(
                  hint: 'password',
                  obscureText: true,
                  validator: _validatePassword,
                ),
                const SizedBox(height: 42),
                AuthButton(label: 'SIGN IN', onPressed: _signIn),
                const SizedBox(height: 16),
                AuthButton(
                  label: 'CREATE AN ACCOUNT',
                  color: authSecondaryColor,
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const SignUpScreen(),
                    ),
                  ),
                ),
                const SizedBox(height: 34),
                ArrowPrompt(
                  label: 'Forgot password?',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const ForgotPasswordScreen(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String? _validatePassword(String? value) =>
    value == null || value.trim().isEmpty ? 'Password invalide' : null;
