import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry_app/core/constants/app_colors.dart';

class CustomTextform extends StatefulWidget {
  const CustomTextform({
    super.key,
    required this.controller,
    required this.isPassword,
    required this.hint,
  });

  final TextEditingController controller;
  final bool isPassword;
  final String hint;

  @override
  State<CustomTextform> createState() => _CustomTextformState();
}

class _CustomTextformState extends State<CustomTextform> {
  late bool _obsacureText;

  initState() {
    super.initState();
    _obsacureText = widget.isPassword;
  }

  void _toggleObscureText() {
    setState(() {
      _obsacureText = !_obsacureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorColor: AppColors.primaryColor,
      cursorHeight: 20,
      // ignore: body_might_complete_normally_nullable
      validator: (v) {
        if (v == null || v.isEmpty) {
          return "Please enter ${widget.hint}";
        }
      },
      obscureText: _obsacureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
        ),
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: _toggleObscureText,
                child: Icon(CupertinoIcons.eye,color: AppColors.primaryColor),
              )
            : null,

        filled: true,
        fillColor: Colors.transparent,
        hintText: widget.hint,
        hintStyle: TextStyle(color: AppColors.primaryColor),
      ),
    );
  }
}
