import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  final double rating;
  final double size;
  const RatingBar({Key ? key, required this.rating, this.size = 18 }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> starlist = [];
    int realnumber = rating.floor();
    int partnumber = ((rating - realnumber) * 10).ceil();

    for (int i = 1; i <= 5; i++) {
      if (i < realnumber) {
        starlist.add(Icon(Icons.star, color: Colors.orange, size: size));
      } else if(i == realnumber){
        starlist.add(SizedBox(
          height: size,
          width: size,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Icon(Icons.star, color: Colors.orange,size: size),
              ClipRect(
                clipper:  _Clipper(part: partnumber),
                child: Icon(Icons.star_border, color: Colors.orange,size: size),
              )
            ],
          ),
        ));
      } else {
        starlist.add(Icon(Icons.star_border, color: Colors.orange, size: size));
      }
    }
    return Row(
      mainAxisSize:  MainAxisSize.min,
      children: starlist,
    );
  }
}

class _Clipper extends CustomClipper<Rect> {
  final int part;

  _Clipper({required this.part});

  @override
  Rect getClip(Size size){
    return Rect.fromLTRB(
      (size.width/10) * part,
      0.0,
      size.width,
      size.height,
      );
  }

  @override 
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}