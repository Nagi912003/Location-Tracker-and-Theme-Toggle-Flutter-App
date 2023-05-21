import 'package:flutter/material.dart';

enum MyThemeMode { LIGHT, DARK }

class MyColors with ChangeNotifier{
  bool isDark = false;
  MyThemeMode theme = MyThemeMode.LIGHT;
  MyThemeMode darkTheme = MyThemeMode.DARK;
  MyThemeMode lightTheme = MyThemeMode.LIGHT;
  Color myGrey = Colors.grey[700]!;
  Color myBlack = Colors.black.withOpacity(0.7);
  Color myCardBackGroundColor = Colors.white.withRed(255).withGreen(250).withBlue(255);

  Color myBackGroundColor = Colors.white;

  Color myCardColor = Colors.white.withRed(255).withGreen(250).withBlue(255);

  Color myBlackTitle = Colors.black;
  Color myText = Colors.black.withOpacity(0.7);
  Color myTextTitle = Colors.black;
  Color myButtonText = Colors.deepPurple;

  void toggleTheme(){
    isDark = !isDark;
    isDark?theme = lightTheme:theme = darkTheme;
    myBackGroundColor = isDark?Colors.black:Colors.white;
    myText = isDark?Colors.white:myBlack;
    myTextTitle = isDark?Colors.white:myBlackTitle;
    myCardColor = isDark?Colors.deepPurple:myCardBackGroundColor;
    myGrey = isDark?Colors.white:Colors.grey[700]!;
    myButtonText = isDark?Colors.white:Colors.deepPurple;
    notifyListeners();
  }

}
