// import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utilis/custom_theme.dart';
import '../../../utilis/dimensions.dart';
import '../../../utilis/images.dart';
import 'package:flutter/material.dart';
import '../seller_add_product.dart';
import 'animated_floating_button.dart';
import 'pagineted_list.dart';
import 'shop_product.dart';
import '../../../bloc/Products/products_bloc.dart';

class Allproduct extends StatefulWidget {
  const Allproduct({super.key});

  @override
  State<Allproduct> createState() => _AllproductState();
}

class _AllproductState extends State<Allproduct> {
  ScrollController scrollController = ScrollController();
  String message = "";
  bool activated = false;
  bool endScroll = false;

  _scrollListener(){
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
      !scrollController.position.outOfRange) {
      setState(() {
        endScroll = true;
        message = "bottom";
      });
    } else {
      endScroll = false;
    }
  }

  @override 
  void dispose(){
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState(){
    scrollController = ScrollController();
    scrollController.addListener((_scrollListener));
    context.read<ProductsBloc>().add(const ProductsEvent.getProduct());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child:  Stack(
          children: [
            NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                return false;
              },
              child: SingleChildScrollView(
                controller:  scrollController,
                child: BlocBuilder<ProductsBloc, ProductsState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: (){
                        return const Text('Server error');
                      },
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    loaded: (data) {
                      return Paginatedlist(
                        reverse: false,
                        scrollController: scrollController,
                        onPaginate: (int? Offset) async {},
                        totalSize: data.data.length,
                        offset: 3,
                        itemView: ListView.builder(
                          itemCount: data.data.length,
                          padding: const EdgeInsets.all(0),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context,int index ){
                            return ShopProduct(
                              product: data.data[index]);
                          },
                        ),
                      );
                    },
                  );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              left: null,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Scrollingfabanimated(
                  width: 150,
                  color: Theme.of(context).cardColor,
                  icon: SizedBox(width: Dimensions.iconSizeExtraLarge,child: Image.asset(Images.addIcon)), 
                  text: Text(
                    'Add new',
                    style: robotoRegular.copyWith(),
                  ), 
                  onPress: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_){
                      return const SelleraddProduct();
                    }));
                  },
                  animateIcon: true,
                  inverted: false, 
                  scrollController: scrollController,
                  radius: 10.0,
                ),
              ))
          ],
        ),
      ),);
  }
}