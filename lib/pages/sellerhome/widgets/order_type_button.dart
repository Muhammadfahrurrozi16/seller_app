// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../utilis/color_resource.dart';
import '../../../utilis/custom_theme.dart';
import '../../../utilis/dimensions.dart';

class OrderTypebutton extends StatelessWidget {
  final String ? text;
  final String ? subText;
  final Color ? color;
  final int index;
  final Function? callback;
  final int ? numberOfOrder;
  const OrderTypebutton({
    Key? key,
    required this.text,
    this.subText,
    this.color,
    required this.index,
    required this.callback,
    required this.numberOfOrder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
        ),
        color: color,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
              child: Container(
                alignment: Alignment.center,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(numberOfOrder.toString(),
                      style: robotoBold.copyWith(
                        color: ColorResources.getWhite(context),
                        fontSize: Dimensions.fontSizeHeaderLarge
                      )),
                    Row(
                      children: [
                        Text(text!,
                        style: robotoRegular.copyWith(
                          color: ColorResources.getWhite(context),
                          fontSize: Dimensions.fontSizeDefault
                        )),
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                        Text(subText!,
                        style: robotoRegular.copyWith(
                          color: ColorResources.getWhite(context)
                        )),
                      ],
                    ),
                    ],
                  ),
                ),
              ),
              ),
            Row(
              children: [
                const Spacer(),
                Container(width: MediaQuery.of(context).size.width/4,
                height: MediaQuery.of(context).size.width/4,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(.10),
                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(100))
                ),),
                const SizedBox.shrink(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
