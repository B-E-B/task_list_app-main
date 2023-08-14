import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final dynamic bloc;
  final String label;
  const MyTextField({super.key, required this.bloc, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: bloc.controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.blueAccent,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        alignLabelWithHint: true,
      ),
      textAlign: TextAlign.center,
    );
  }
}
