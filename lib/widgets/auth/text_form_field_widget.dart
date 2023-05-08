import 'package:flutter/material.dart';
import 'package:internship/core/global/colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.hintText,
    required this.validator,
    required this.controller,
    required this.icon,
    this.isPass,
    this.textInputType,
  });

  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final IconData icon;
  final bool? isPass;
  final TextInputType? textInputType;
  final double radius = 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [primaryColor, secondaryColor]),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(radius),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(icon),
        ),
        validator: validator,
        controller: controller,
        obscureText: isPass ?? false,
        keyboardType: textInputType,
      ),
    );
  }
}
