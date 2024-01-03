import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utilis/custom_theme.dart';

extension EmailValidator on String {
  bool isValidEmail(){
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(this);
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController ? controller;
  final String ? hintText;
  final TextInputType ? textInputType;
  final int? maxLine;
  final FocusNode ? focusNode;
  final FocusNode ? nexNode;
  final TextInputAction ? textInputAction;
  final bool isPhoneNumber;
  final bool isValidator;
  final String ? validatorMessage;
  final Color ? fillcolor;
  final TextCapitalization capitalization;
  final bool isBorder;
  final TextAlign? textAlign;
  final bool isEnable;
  
  const CustomTextField({
    Key? key,
    this.controller,
    this.hintText,
    this.textInputType,
    this.maxLine,
    this.focusNode,
    this.nexNode,
    this.textInputAction,
    this.isPhoneNumber = false,
    this.isValidator = false,
    this.validatorMessage,
    this.capitalization = TextCapitalization.none,
    this.fillcolor,
    this.isBorder = false,
    this.textAlign,
    this.isEnable = true,
  }) : super(key: key);

  @override
  Widget build(context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: isBorder
          ? Border.all(width: .8, color: Theme.of(context).hintColor)
          : null,
        color: Theme.of(context).highlightColor,
        borderRadius: isPhoneNumber
          ? const BorderRadius.only(
            topRight: Radius.circular(6),bottomRight: Radius.circular(6))
          : BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1))
        ],
      ),
      child: TextFormField(
        textAlign: textAlign != null
          ? textAlign!
          : isBorder
              ? TextAlign.center
              : TextAlign.start,
        controller: controller,
        maxLines: maxLine ?? 1,
        textCapitalization: capitalization,
        maxLength: isPhoneNumber ? 15 : null,
        focusNode: focusNode,
        keyboardType: textInputType ?? TextInputType.text,
        enabled: isEnable,
        initialValue: null,
        textInputAction: textInputAction ?? TextInputAction.next,
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(nexNode);
        },
        inputFormatters: [
          isPhoneNumber 
            ? FilteringTextInputFormatter.digitsOnly
            : FilteringTextInputFormatter.singleLineFormatter
        ],
        validator: (input){
          if (input!.isEmpty) {
            if (isValidator) {
              return validatorMessage ?? "";
            }
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: hintText ?? '',
          filled: fillcolor != null,
          fillColor: fillcolor,
          contentPadding: 
            const EdgeInsets.symmetric(vertical: 12.0,horizontal: 15),
          isDense: true,
          counterText: '',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          hintStyle: 
              titilliumRegular.copyWith(color: Theme.of(context).hintColor),
          errorStyle: const TextStyle(height: 1.5),
          border: InputBorder.none
        ),
      ),
    );
  }
}