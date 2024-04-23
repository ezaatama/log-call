import 'package:flutter/material.dart';

class CalendarTextField extends StatelessWidget {
  CalendarTextField(
      {super.key,
      this.controller,
      required this.onTap,
      required this.hintText,
      required this.hintStyle,
      this.validator,
      this.decoration});

  final TextEditingController? controller;
  final Function() onTap;
  final String hintText;
  final TextStyle hintStyle;
  final String? Function(String?)? validator;
  InputDecoration? decoration = const InputDecoration();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      cursorColor: Colors.amber,
      cursorWidth: 2,
      cursorHeight: 15,
      style: const TextStyle(fontSize: 14),
      validator: validator,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        prefix: const Padding(padding: EdgeInsets.only(left: 12.0)),
        isDense: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(width: 2, color: Colors.amber)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Colors.amber)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(4.0)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Colors.red)),
        hintText: hintText,
        hintStyle: hintStyle,
      ),
      onTap: onTap,
    );
  }
}
