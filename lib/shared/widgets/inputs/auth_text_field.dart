import 'package:flutter/material.dart';

/// Was widgets/buildauth_textfeild.dart (a plain class with a builder
/// method). Converted to a proper StatelessWidget per §06.1 rule 6 —
/// one widget per file, no data fetching, everything via constructor.
class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
    final String? lableText;
  final String? Function(String?) validator;
  final bool isObscure;
  final Widget? suffixIcon;
    final Widget? prefixIcon;
  final TextInputType? keyboardType;

  const AuthTextField( {
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.isObscure = false,
    this.suffixIcon,
    this.keyboardType, this.prefixIcon, this.lableText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 300,
      child: TextFormField(
        
        validator: validator,
        controller: controller,
        obscureText: isObscure,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText:lableText,
          prefixIcon: prefixIcon,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18))
          ),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 20),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
