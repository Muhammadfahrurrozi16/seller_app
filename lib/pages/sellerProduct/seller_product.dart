// import 'package:flutter/foundation.dart';
import '../base_widget/custom_app_bar.dart';
import '../../utilis/dimensions.dart';
import '../../utilis/images.dart';
import 'widgets/all_product.dart';
import 'widgets/custom_search.dart';
import 'package:flutter/material.dart';

class SellerProduct extends StatefulWidget {
  const SellerProduct({super.key});

  @override
  State<SellerProduct> createState() => _SellerProductState();
}

class _SellerProductState extends State<SellerProduct> {
  TextEditingController searhController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomBarApp(title: 'Product list'),
      body: Column(
        children: [
          SizedBox(
            height: 80,
            child: Container(
              color: Theme.of(context).cardColor,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  Dimensions.paddingSizeDefault, 
                  Dimensions.paddingSizeDefault,
                  Dimensions.paddingSizeDefault,
                  Dimensions.paddingSizeDefault),
                  child: Customsearch(
                    controller: searhController,
                    hint: 'Search',
                    prefix: Images.iconsSearch,
                    iconPressed: () => (){},
                    onsubmit: (text) => (){},
                    onChanged: (value){},
                    ),
                  ),
            ),
          ),
          Expanded(child: Allproduct())
        ],
      ),
    );
  }
}