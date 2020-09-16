
import 'package:flutter/cupertino.dart';

class SizeConfig{

  BuildContext _context;
  static double screenWidth;
  static double screenHeight;
  static final double prototypeWidth = 375;

  void init(BuildContext context) {
    _context = context;
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  static double sizeByPixel(double pixel) {
    return screenWidth * (pixel / prototypeWidth);
  }

}