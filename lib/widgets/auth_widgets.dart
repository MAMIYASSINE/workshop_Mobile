import 'package:flutter/material.dart';

const Color authPageColor = Color(0xFFFFF8FF);
const Color authAccentColor = Color(0xFFFF7043);
const Color authSecondaryColor = Color(0xFFF44336);

class MovieLogo extends StatelessWidget {
  const MovieLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 250,
      child: Center(
        child: Icon(
          Icons.movie_creation_rounded,
          size: 150,
          color: Color(0xFF202124),
        ),
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircleAvatar(
        radius: 68,
        backgroundColor: Color(0xFFFFB64D),
        child: Icon(Icons.person, size: 88, color: Color(0xFFE74478)),
      ),
    );
  }
}

class AuthField extends StatelessWidget {
  const AuthField({
    required this.hint,
    super.key,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines = 1,
  });

  final String hint;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: obscureText ? 1 : maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFFBDB8BE)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Color(0xFFAAA4AA)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Color(0xFFAAA4AA)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: authAccentColor, width: 1.5),
        ),
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  const AuthButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.color = authAccentColor,
  });

  final String label;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: const StadiumBorder(),
        ),
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class ArrowPrompt extends StatelessWidget {
  const ArrowPrompt({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(child: Text(label, textAlign: TextAlign.end)),
        const SizedBox(width: 12),
        const Icon(Icons.arrow_forward, color: authAccentColor, size: 24),
      ],
    );
  }
}