import 'package:app_pfe/ressources/dimensions/constants.dart';
import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String label;
  final TextInputType textInputType;
  final TextEditingController controller;
  final Widget? prefixWidget;
  final int? lines;

  const InputField(
      {Key? key, required this.label, required this.textInputType, required this.controller, this.prefixWidget, this.lines})
      : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool obscurePassword = true;
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Constants.screenHeight * 0.001),
      child: Container(
        height: Constants.screenHeight * 0.1,
        child: TextFormField(
          maxLines: widget.lines != null ? widget.lines : 1,
          style: TextStyle(fontSize: 18),
          controller: widget.controller,
          validator: (value) {
            if (value!.isEmpty) {
              return "Champ obligatoire";
            } else if (widget.label == "Email") {
              bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
              if (!emailValid) {
                return "Format ivalide d'email";
              }
            }
          },
          keyboardType: widget.textInputType,
          cursorColor: Colors.black,
          obscureText: widget.textInputType == TextInputType.visiblePassword ? obscurePassword : false,
          decoration: InputDecoration(
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            prefixIcon: widget.prefixWidget,
            suffixIcon: widget.textInputType == TextInputType.visiblePassword
                ? GestureDetector(
                    child: obscurePassword
                        ? Icon(Icons.visibility, color: Colors.lightGreen)
                        : Icon(Icons.visibility_off, color: Colors.grey),
                    onTap: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  )
                : null,
            hintText: widget.label,
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 2.0,
                color: Colors.lightGreen.withOpacity(0.5),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Colors.lightGreen,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
