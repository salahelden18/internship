import 'package:flutter/material.dart';

class TextFormFieldGlobalWidget extends StatelessWidget {
  const TextFormFieldGlobalWidget({
    super.key,
    required this.validator,
    required this.text,
    required this.controller,
    this.textInputAction,
  });

  final String? Function(String?)? validator;
  final String text;
  final TextInputAction? textInputAction;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      style: const TextStyle(color: Colors.black, fontSize: 16),
      textInputAction: textInputAction,
      controller: controller,
      decoration: InputDecoration(
        label: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
        contentPadding: const EdgeInsets.only(left: 10, right: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
