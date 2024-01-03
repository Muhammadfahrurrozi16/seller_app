import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../utilis/custom_theme.dart';
import '../../../utilis/dimensions.dart';
import '../../../utilis/images.dart';

class Customsearch extends StatefulWidget {
  final TextEditingController? controller;
  final String? hint;
  final String prefix;
  final Function iconPressed;
  final Function? onsubmit;
  final Function? onChanged;
  final Function? filterAction;
  final bool isFiller;
  const Customsearch({
    Key? key,
    required this.controller,
    required this.hint,
    required this.prefix,
    required this.iconPressed,
    this.onsubmit,
    this.onChanged,
    this.filterAction,
    this.isFiller = false,
  }) : super(key: key);

  @override
  State<Customsearch> createState() => _CustomsearchState();
}

class _CustomsearchState extends State<Customsearch> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: widget.controller,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
              color: Theme.of(context).disabledColor.withOpacity(.5)),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              ),
              filled: true,
              fillColor: Theme.of(context).primaryColor.withOpacity(.07),
              isDense: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor,width: .70),
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeMedium),
                child: SizedBox(width: Dimensions.iconSizeExtraSmall,child: Image.asset(widget.prefix)),
              ),
            ),
            onSubmitted: widget.onsubmit as void Function(String)?,
            onChanged: widget.onChanged as void Function(String)?,
          ),
        ),
        widget.isFiller ? Padding(
          padding: EdgeInsets.only(
            left: 0,
            right: Dimensions.paddingSizeExtraSmall
          ),
          child: GestureDetector(
            onTap: widget.filterAction as void Function()?,
            child: Container(decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
            ),
            padding: const EdgeInsets.all(Dimensions.paddingSizeMedium),
            child: Image.asset(Images.filterIcon,width: Dimensions.paddingSizeLarge),
          ),
          ),
     ): const SizedBox(),
      ],
    );
  }
}