import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatelessWidget {
  const CustomDropdownMenu(
      {super.key,
      required this.initialSelection,
      required this.dropdownMenuEntries,
      required this.onSelected,
      required this.label});

  final String initialSelection;
  final List<DropdownMenuEntry<String>> dropdownMenuEntries;
  final Function(String?) onSelected;
  final String label;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      inputDecorationTheme: const InputDecorationTheme(
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)))),
      width: double.infinity,
      label: Text(label),
      textStyle: const TextStyle(color: Colors.black),
      initialSelection: initialSelection,
      onSelected: onSelected,
      dropdownMenuEntries: dropdownMenuEntries,
    );
  }
}
