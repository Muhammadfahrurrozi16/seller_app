// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../utilis/color_resource.dart';
import '../../../utilis/custom_theme.dart';
import '../../../utilis/dimensions.dart';
import '../../../utilis/images.dart';
import 'order_type_button.dart';

class OngoingWidget extends StatelessWidget {
  final Function? callback;
  const OngoingWidget({
    Key? key,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: ColorResources.getPrimary(context).withOpacity(.05),
            spreadRadius: -3,
            blurRadius: 12,
            offset: Offset.fromDirection(0,6)
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeMedium
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: Dimensions.iconSizeLarge,
                  height: Dimensions.iconSizeLarge,
                  padding: const EdgeInsets.only(
                    left: Dimensions.paddingSizeExtraSmall
                  ),
                  child: Image.asset(Images.monthlyEarning)
                ),
                const SizedBox(width: Dimensions.paddingSizeSmall,),
                Text('Businnes Analytics',
                style: robotoBold.copyWith(
                  color: ColorResources.getTextColor(context),
                  fontSize: Dimensions.fontSizeDefault
                ),
              ),
              const Expanded(child: SizedBox(width: Dimensions.paddingSizeLarge,)),
              Container(
                height: 50,
                width: 120,
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeSmall
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  border: Border.all(
                    width: .7,
                    color: Theme.of(context).hintColor.withOpacity(.3)
                  ),
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                ),
                child: DropdownButton<String>(
                  value: 'Overall',
                  items: <String>['overall','today','this_mouth'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        'Overall',
                        style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeDefault
                        ),
                      ),
                    );
                  }).toList(),
                   onChanged: (value){},
                   isExpanded: true,
                   underline: const SizedBox(),
                  ),
              )
              ],
            ),
          ),
          const SizedBox(height: Dimensions.paddingSizeSmall,),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              Dimensions.paddingSizeDefault, 
              Dimensions.paddingSizeExtraSmall,
              Dimensions.paddingSizeDefault,
              Dimensions.paddingSeven),
            child: Text(
              'Ongoing orders',
              style: robotoBold.copyWith(color: Theme.of(context).primaryColor),
            ), 
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              Dimensions.paddingSizeSmall,
              0,
              Dimensions.paddingSizeSmall,
              Dimensions.fontSizeSmall),
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: (1 / .65),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                OrderTypebutton(
                  color: ColorResources.mainCardOneColor(context),
                  text: 'Pending',
                  index: 1,
                  callback: callback,
                  numberOfOrder: 3,
                  subText: 'Orders',
                ),
                OrderTypebutton(
                  color: ColorResources.mainCardTwoColor(context),
                  text: 'Packaging',
                  index: 2,
                  callback: callback,
                  numberOfOrder: 4,
                  subText: 'Orders',
                ),
                OrderTypebutton(
                  color: ColorResources.mainCardThreeColor(context),
                  text: 'Confirmed',
                  index: 7,
                  callback: callback,
                  numberOfOrder: 5,
                  subText: 'Orders',
                ),
                OrderTypebutton(
                  color: ColorResources.mainCardFourColor(context),
                  text: 'out of delivery',
                  index: 8,
                  callback: callback,
                  numberOfOrder: 6,
                  subText: '',
                ),
              ],
            ),
          ),
          const SizedBox(height: Dimensions.paddingSizeSmall),
        ],
      ),
    );
  }
}
