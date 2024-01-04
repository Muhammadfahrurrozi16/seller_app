import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seller_app_fic/common/Global_Variabel.dart';

import '../../../utilis/images.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double ? height;
  final double ? width;
  final BoxFit fit;
  final String placeholder;
  const CustomImage({
    Key? key,
    required this.image,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.placeholder = Images.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      height: height,
      width: width,
      fit: BoxFit.cover,
      placeholder: Images.placeholder,
      image: image.contains('http') ? image : GlobalVariables.baseUrl+image,
      imageErrorBuilder: (context, error, stackTrace) => Image.asset(
        Images.placeholder,
        height: height,
        width: width,
        fit: BoxFit.cover,
      ),
    );
  }
}
