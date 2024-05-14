import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String errorText;
  final bool isObscureText;
  const AuthField(
      {super.key,
      required this.hintText,
      required this.errorText,
      required this.controller,
      this.isObscureText = false});

  @override
  Widget build(BuildContext context) {
    border(Color color) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: color,
            width: 3,
          ),
        );

    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorText;
        }
        return null;
      },
      controller: controller,
      obscureText: isObscureText,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.w500,
        ),
        errorText: null,
        contentPadding: const EdgeInsets.all(16),
        border: border(Theme.of(context).colorScheme.inversePrimary),
        focusedBorder: border(Colors.deepPurple),
      ),
    );
  }
}
