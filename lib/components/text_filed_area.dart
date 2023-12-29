import 'package:flutter/material.dart';

class TextFormFieldArea extends StatelessWidget {
  final String title;
  final Color color;
  final TextEditingController controller;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? suffix;
  final bool obscureText;
  final bool enabled;

  const TextFormFieldArea({
    super.key,
    required this.title,
    required this.controller,
    required this.textInputType,
    this.color = Colors.orange,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.suffix,
    this.obscureText=false,
    this.enabled=true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        suffix: suffix,
        errorStyle: const TextStyle(color: Colors.red, fontStyle: FontStyle.italic),
        hintStyle: const TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
        labelText: title,
        floatingLabelStyle: TextStyle(color: Colors.green.shade600),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.black, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
      ),
      validator: validator, // Pass the validator function here
    );
  }
}
