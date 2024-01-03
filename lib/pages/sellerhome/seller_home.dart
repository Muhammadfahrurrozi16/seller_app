// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../utilis/color_resource.dart';
import '../../utilis/dimensions.dart';
import '../../utilis/images.dart';
import 'widgets/ongoing_order_widget.dart';

class SellerHome extends StatefulWidget {
  const SellerHome({super.key});

  @override
  State<SellerHome> createState() => _SellerHomeState();
}

class _SellerHomeState extends State<SellerHome> {
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    double limitedStockCardHeight = MediaQuery.of(context).size.width / 1.4;
    return Scaffold(
      backgroundColor: ColorResources.getHomeBg(context),
      body: CustomScrollView(
        controller: _controller,
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            elevation: 0,
            centerTitle: false,
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).highlightColor,
            title: Image.asset(Images.logoWithNameImage,height: 35),
          ),
          const SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimensions.paddingSizeSmall),
                OngoingWidget(),

                SizedBox(height: Dimensions.paddingSizeSmall),
                SizedBox(height: Dimensions.paddingSizeSmall),
              ],
            ),
          )
        ],
      ),
    );
  }
}