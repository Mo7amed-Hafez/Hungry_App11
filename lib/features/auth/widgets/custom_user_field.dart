import 'package:flutter/material.dart';

class CustomUserField extends StatelessWidget {
  const CustomUserField({super.key, required this.lableTitle, required this.controller, this.textType});

  final TextEditingController controller;
  final String lableTitle;
  final TextInputType ? textType;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, 
      keyboardType: textType,
      style: TextStyle(color: Colors.white, fontSize: 18),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        labelText: lableTitle,
        
        focusColor: Colors.white,
        
        labelStyle: TextStyle(color: Colors.white, fontSize: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
      ),
    );
  }
}
