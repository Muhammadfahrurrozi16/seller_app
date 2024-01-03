
import 'package:flutter/material.dart';
import 'package:seller_app_fic/pages/auth/widgets/sign_in_widget.dart';
import 'package:seller_app_fic/pages/auth/widgets/sign_up_widget.dart';
import '../../utilis/color_resource.dart';
import '../../utilis/custom_theme.dart';
import '../../utilis/dimensions.dart';
import '../../utilis/images.dart';

class AuthPage extends StatefulWidget {
  final int initialPage;
  const AuthPage({Key ? key, this.initialPage= 0 }): super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool IsLoginPage = true;
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: widget.initialPage);

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Image.asset(
            Images.background,
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: Dimensions.topSpace),
                Image.asset(
                  Images.logoWithNameImage,height: 150, width: 200
                ),
                Padding(padding: const EdgeInsets.all(Dimensions.marginSizeLarge),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      bottom: 0,
                      right: Dimensions.marginSizeExtraSmall,
                      left: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        color: ColorResources.getGainsBoro(context),
                      ),
                      ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => pageController.animateToPage(0, duration: const Duration(seconds: 1), curve: Curves.easeInOut),
                        child: Column(
                          children: [
                            Text('Sign IN ', style: IsLoginPage
                                  ? titilliumBold
                                  : titilliumRegular),
                            Container(
                              height: 1,
                              width: 40,
                              margin: const EdgeInsets.only(top: 8),
                              color: IsLoginPage
                                  ? Theme.of(context).primaryColor
                                  : Colors.transparent),
                          ],
                        ),
                        ),
                        const SizedBox(
                          width: Dimensions.paddingSizeExtraLarge),
                        InkWell(
                          onTap: () => pageController.animateToPage(1, duration: const Duration(seconds: 1), curve: Curves.easeInOut),
                          child: Column(
                            children: [
                              Text('Sign Up', style: !IsLoginPage
                                    ? titilliumBold
                                    : titilliumRegular),
                            Container(
                              height: 1,
                              width: 50,
                              margin: const EdgeInsets.only(top: 8),
                              color: !IsLoginPage
                                  ? Theme.of(context).primaryColor
                                  : Colors.transparent
                            ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  itemCount: 2,
                  controller: pageController,
                  itemBuilder: (context, index) {
                    if (IsLoginPage) {
                      return const SignInWidget();
                    } else {
                      return const SignUpWidget();
                    }
                  },
                  onPageChanged: (index){
                    setState(() {
                      IsLoginPage = !IsLoginPage;
                    });
                  },
                  )
                )
              ],
            ))
        ], ),
    );
  }
}