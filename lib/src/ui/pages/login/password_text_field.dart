import 'package:attado_mobile/src/ui/strings/strings.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField(
      {super.key, required this.controller, required this.authException});

  final TextEditingController controller;
  final bool authException;

  @override
  State<StatefulWidget> createState() => PasswordTextFieldState();
}

class PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscurePassword = true;

  void _changeObscure() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.password_outlined),
        suffixIcon: IconButton(
            onPressed: _changeObscure,
            icon: _obscurePassword
                ? const Icon(Icons.visibility_outlined)
                : const Icon(Icons.visibility_off_outlined)),
        border: const OutlineInputBorder(),
        labelText: Strings.loginLabelPassword,
        errorText: widget.authException ? Strings.loginErrorUnauthorized : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return Strings.loginErrorRequired;
        }
        return null;
      },
    );
  }
}
