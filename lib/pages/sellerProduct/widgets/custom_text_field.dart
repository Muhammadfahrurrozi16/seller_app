// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seller_app_fic/utilis/custom_theme.dart';
import 'package:seller_app_fic/utilis/dimensions.dart';

extension EmailValidator on String {
  bool isValidEmail(){
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(this);
  }
}

class CustomTextfield extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? textInputType;
  final int? maxLine;
  final FocusNode? focusNode;
  final FocusNode? nexNode;
  final TextInputAction? textInputAction;
  final bool isPhoneNumber;
  final bool isValidator;
  final String? validatorMeassage;
  final Color? fillColor;
  final TextCapitalization capitalization;
  final bool isAmount;
  final bool amountIcon;
  final bool border;
  final bool isDescription;
  final bool idDate;
  final bool isPassword;
  final Function(String text)? onChanged;
  final String? prefixIconImage;
  final bool isPos;
  final int? maxSize;
  final bool varianta;
  const CustomTextfield({
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
    this.validatorMeassage,
    this.fillColor,
    this.capitalization = TextCapitalization.none,
    this.isAmount = false,
    this.amountIcon = false,
    this.border = false,
    this.isDescription = false,
    this.idDate = false,
    this.isPassword = false,
    this.onChanged,
    this.prefixIconImage,
    this.isPos = false,
    this.maxSize,
    this.varianta = false,
  }) : super(key: key);

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
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
        border: widget.border? Border.all(width: 1,color: Theme.of(context).hintColor.withOpacity(.35)):null,
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)
      ),
      child: TextFormField(
        controller: widget.controller,
        maxLines: widget.maxLine?? 1,
        textCapitalization: widget.capitalization,
        maxLength: widget.maxSize ?? (widget.isPhoneNumber ? 15 : null),
        focusNode: widget.focusNode,
        initialValue: null,
        obscureText: widget.isPassword?_obscureText: false,
        onChanged: widget.onChanged,
        enabled: widget.idDate? false:true,
        inputFormatters: (widget.textInputType == TextInputType.phone || widget.isPhoneNumber ) ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9+]'))]
        : widget.isAmount ? [FilteringTextInputFormatter.allow(RegExp('[0-9+]'))] : null,
        keyboardType: widget.isAmount ? TextInputType.number : widget.textInputType ?? TextInputType.text,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(widget.nexNode);
        },
        validator: (input) {
          if (input!.isEmpty) {
            if (widget.isValidator) {
              return widget.validatorMeassage?? "";
            }
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIconConstraints: BoxConstraints(
            minWidth: widget.varianta ? 5 : 20,
            minHeight: widget.varianta ? 5 : 20,
          ),
          prefixIcon: widget.prefixIconImage != null ?
          Padding(
            padding: const EdgeInsets.fromLTRB(
              0, 
              0, 
              Dimensions.paddingSizeSmall,
              0),
            child: Container(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(.135)
              ),
              child: Image.asset(widget.prefixIconImage!,width: 20, height: 20,)
              ),
            ): const SizedBox(),
            suffixIconConstraints: BoxConstraints(
              minWidth: widget.varianta ? 5 : widget.isPos? 0:40,
              minHeight: widget.varianta ? 5 : 20,
            ),
            suffixIcon: widget.isPassword? GestureDetector(
              onTap: _toggle,
              child: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
            ):const SizedBox.shrink(),
            hintText: widget.hintText ?? '',
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
            filled: widget.fillColor != null,
            fillColor: widget.fillColor,
            isDense: true,
            counterText: '',
            hintStyle: titilliumRegular.copyWith(color: Theme.of(context).hintColor),
            errorStyle:  const TextStyle(height: 1.5),
            border: InputBorder.none,
        ),
      ),
    );
  }
}