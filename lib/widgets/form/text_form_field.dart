import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      required this.textEditingController,
      required this.label,
      required this.hintText,
      this.validator,
      this.initialValue});

  final TextEditingController textEditingController;
  final String label;
  final String hintText;
  final String? Function(String?)? validator;
  String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue ?? "",
      controller: textEditingController,
      validator: validator,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
          label: Text(label),
          hintText: hintText,
          hintStyle: const TextStyle(color: Color.fromRGBO(130, 132, 144, 1)),
          filled: true,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          fillColor: Colors.transparent),
    );
  }
}
