// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../Data/Models/Product_model_respon.dart';
import '../../../utilis/color_resource.dart';
import '../../../utilis/custom_theme.dart';
import '../../../utilis/dimensions.dart';
import '../../../utilis/price_ext.dart';
import 'custom_image.dart';

class ShopProduct extends StatefulWidget {
  final Product product;
  const ShopProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ShopProduct> createState() => _ShopProductState();
}

class _ShopProductState extends State<ShopProduct> {
  var renderOverlay = true;
  var visible = true;
  var swithLabelPosition = false;
  var extend = false;
  var mini = false;
  var customDialRoot = false;
  var closeManually = false;
  var useRanimation = true;
  var isDialOpen = ValueNotifier<bool>(false);
  var buttomSize = const Size(35.0, 35.0);
  var childrenButtonSize = const Size(45.0, 45.0);

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
          child: GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeMedium,
                vertical: Dimensions.paddingSizeSmall
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(.05),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(1, 2)
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: Dimensions.paddingSizeSmall
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor.withOpacity(.10),
                                borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                              ),
                              width: 100,
                              height: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                child: CustomImage(image: widget.product.imageProduct)
                              )
                            ),
                            const SizedBox(
                              height: Dimensions.paddingSizeExtraSmall
                            ),
                            Text(
                              widget.product.category.name,
                              style: robotoRegular.copyWith(
                                color: Theme.of(context).primaryColor
                              ),
                            ),
                          ],
                        ), 
                      ),
                      const SizedBox(
                        width: Dimensions.paddingSizeSmall,
                      ),
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 0,
                                  left: 30,
                                ),
                                child: Text(widget.product.name,
                                style: robotoRegular.copyWith(
                                  color: ColorResources.titleColor(context)
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis),
                               ),
                              const SizedBox(height: Dimensions.paddingSizeSmall),
                              Container(padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeSmall,
                                vertical: Dimensions.paddingSizeExtraSmall
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                                color: ColorResources.getRed(context)
                              ),
                              child: Text('New',
                              style: robotoRegular.copyWith(
                                color: Colors.white
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis)),
                            const SizedBox(
                              height: Dimensions.paddingSizeSmall
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Selling price :',
                                      style: robotoRegular.copyWith(
                                        color: Theme.of(context).hintColor
                                      ),
                                    ),
                                    Text('${widget.product.price}'.formatPrice(),
                                    style: robotoMedium.copyWith(
                                      color: ColorResources.titleColor(context)
                                    ))
                                  ]),
                              ],
                            )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox.shrink(),
                ],
              ),
            ),
          ), 
        ),
        const SizedBox()
      ],
    );
  }
}