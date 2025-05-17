import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final double screenWidth;
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator; // إضافة خاصية validator هنا

  const CustomTextField({
    required this.screenWidth,
    required this.hint,
    required this.icon,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator, // تضمين validator في الكونستركتور
  });

  String? errorMessages(String hint) {
    switch (hint) {
      case 'Email':
        return 'Please enter a valid email address';
      case 'Password':
        return 'Password must be at least 8 characters';
      case 'Full Name':
        return 'Please enter your full name';
      default:
        return 'This field cannot be empty';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator, // استخدام خاصية validator هنا
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white70),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(12),
          ),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.white24,
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}