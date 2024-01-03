import 'package:flutter/material.dart';

import '../../../utilis/custom_theme.dart';


class CustomPasswordTextField extends StatefulWidget {
  final TextEditingController ? controller;
  final String? hintText;
  final FocusNode? focusNode;
  final FocusNode? nexNode;
  final TextInputAction? textInputAction;

  const CustomPasswordTextField({
    Key ? key,
    this.controller,
    this.hintText,
    this.focusNode,
    this.nexNode,
    this.textInputAction
  }): super(key: key);

  @override
  CustomPasswordTextFieldState createState() => CustomPasswordTextFieldState();
}

class CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _obscureText = true;

  void _toggle(){
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 1)
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: TextFormField(
          cursorColor: Theme.of(context).primaryColor,
          controller: widget.controller,
          obscureText: _obscureText,
          focusNode: widget.focusNode,
          textInputAction: widget.textInputAction ?? TextInputAction.next,
          onFieldSubmitted: (v) {
            setState(() {
              widget.textInputAction == TextInputAction.done
                ? FocusScope.of(context).consumeKeyboardToken()
                : FocusScope.of(context).requestFocus(widget.nexNode);
            });
          },
          validator: (value) {
            return null;
          },
          decoration: InputDecoration(
            suffixIcon: IconButton(onPressed: _toggle, icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility) ),
            hintText: widget.hintText ?? '',
            contentPadding: 
              const EdgeInsets.symmetric(vertical: 12.0,horizontal: 15),
            isDense:  true,
            filled: true,
            fillColor: Theme.of(context).highlightColor,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
            hintStyle: 
              titilliumRegular.copyWith(color: Theme.of(context).hintColor),
            border: InputBorder.none
          ),
        ),
      ),
    );
  }
}