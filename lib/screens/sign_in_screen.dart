import 'package:flutter/material.dart';
import 'package:workshop_flutter__4ei3/widgets/auth_widgets.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: authPageColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
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
              const AuthField(
                hint: 'email',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 18),
              const AuthField(hint: 'password', obscureText: true),
              const SizedBox(height: 42),
              AuthButton(label: 'SIGN IN', onPressed: () {}),
              const SizedBox(height: 16),
              AuthButton(
                label: 'CREATE AN ACCOUNT',
                color: authSecondaryColor,
                onPressed: () {},
              ),
              const SizedBox(height: 34),
              const ArrowPrompt(label: 'Forgot password?'),
            ],
          ),
        ),
      ),
    );
  }
}