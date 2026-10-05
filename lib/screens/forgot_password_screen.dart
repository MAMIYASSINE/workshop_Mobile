import 'package:flutter/material.dart';
import 'package:workshop_flutter__4ei3/widgets/auth_widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)
        ? null
        : 'Email invalide';
  }

  void _sendResetLink() {
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Instructions sent to your email.')),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: authPageColor,
      appBar: AppBar(
        backgroundColor: authPageColor,
        title: const Text('Forgot password?'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const MovieLogo(),
                const SizedBox(height: 32),
                const Text('Enter your email to reset your password.'),
                const SizedBox(height: 20),
                AuthField(
                  hint: 'email',
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 24),
                AuthButton(label: 'SEND RESET LINK', onPressed: _sendResetLink),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
