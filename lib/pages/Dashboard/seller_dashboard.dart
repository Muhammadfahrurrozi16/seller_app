// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../utilis/images.dart';
import '../sellerhome/seller_home.dart';
import '../sellerProduct/seller_product.dart';

class SellerDashboard extends StatefulWidget {
  const SellerDashboard({super.key});

  @override
  State<SellerDashboard> createState() => _SellerDashboardState();
}

class _SellerDashboardState extends State<SellerDashboard> {
  final PageController _pageController = PageController();
  int _pageIndex = 0;
  late List<Widget> _screens;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  
  bool singleVendor = false;

  @override
  void initState(){
    super.initState();

    _screens = [
      const SellerHome(),
      const SellerProduct(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).textTheme.bodyLarge!.color,
        showUnselectedLabels: true,
        currentIndex: _pageIndex,
        type: BottomNavigationBarType.fixed,
        items: _getBottomWidget(singleVendor),
        onTap: (int index) {
          _setPage(index);
        },
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: _screens.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context,index){
          return _screens[index];
        }
      ),
    );
  }

  void _setPage(int pageIndex){
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }

  BottomNavigationBarItem _barItem(String icon, String? label, int index){
    return BottomNavigationBarItem(
      icon: Image.asset(
        icon,
        color: index == _pageIndex
          ? Theme.of(context).primaryColor
          : Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5),
        height: 25,
        width: 25,
      ),
      label: label,
    );
  }
  List<BottomNavigationBarItem> _getBottomWidget(bool isSingleVendor){
    List<BottomNavigationBarItem> list = [];

    if (!isSingleVendor) {
      list.add(_barItem(Images.homeImage, 'Home', 0));
      list.add(_barItem(Images.shoppingImage, 'Product', 1));
      list.add(_barItem(Images.moreImage, 'more', 2));
    } else{
      list.add(_barItem(Images.homeImage, 'Home', 0));
      list.add(_barItem(Images.shoppingImage, 'Product', 1));
      list.add(_barItem(Images.moreImage, 'more', 2));
    }

    return list;
  }
}