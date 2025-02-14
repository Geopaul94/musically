import 'package:flutter/material.dart';

class CustomPasswordTextformField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;

  const CustomPasswordTextformField({super.key, required this.controller, required this.labelText});

  @override
  _CustomPasswordTextformFieldState createState() => _CustomPasswordTextformFieldState();
}

class _CustomPasswordTextformFieldState extends State<CustomPasswordTextformField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: _togglePasswordVisibility,
        ),
        labelText: widget.labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter ${widget.labelText.toLowerCase()}';
        }
        return null;
      },
    );
  }
}
