import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class AppTheme {
   static final lightTheme = ThemeData(
      scaffoldBackgroundColor: const Color(0xFFF6F8FC),
      fontFamily: 'SFPro-Display',
      inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.always),
      splashColor: Color(0xFF32A060),
      colorScheme: const ColorScheme(
          
          primary: Colors.black,
          secondary: Color(0xFF32A060),
          secondaryContainer: Color(0xFF32A060),
          surface: Colors.white,
          background: Color(0xFF32A060),
          error: Color.fromARGB(255, 200, 47, 47),
          onPrimary: Colors.white,

          onSecondary: Colors.black,

          onSurface: Colors.black,

          onBackground: Colors.black,

          onError: Colors.black,
          brightness: Brightness.light),
       textTheme: const TextTheme(
         headline1: TextStyle(
           fontSize: 25,
           color: Color(0xFF32A060),
           fontWeight: FontWeight.bold,
         ),headline2: TextStyle(
             fontSize: 18,
             color: Colors.black,
             fontWeight: FontWeight.w400,
             wordSpacing: 1.2,
             height: 1.2),headline3: TextStyle(
           fontSize: 18,
           color: Color(0xFF32A060),
           fontWeight: FontWeight.bold,
         ),headline4: TextStyle(
           fontSize: 18,
           color: Colors.white,
           fontWeight: FontWeight.bold,
         ),
       )
   );


  static final darkTheme = ThemeData(
       scaffoldBackgroundColor: const Color(0xFFF6F8FC),
      fontFamily: 'SFPro-Display',
      inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.always),
      splashColor: Color(0xFF32A060),
      colorScheme: const ColorScheme(
          
          primary: Colors.black,
          secondary: Color(0xFF32A060),
          secondaryContainer: Color(0xFF32A060),
          surface: Colors.white,
          background: Color(0xFF32A060),
          error: Color.fromARGB(255, 200, 47, 47),
          onPrimary: Colors.white,

          onSecondary: Colors.black,

          onSurface: Colors.black,

          onBackground: Colors.black,

          onError: Colors.black,
          brightness: Brightness.light),
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 25,
              color: Color(0xFF32A060),
              fontWeight: FontWeight.bold,
            ),headline2: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w400,
              wordSpacing: 1.2,
              height: 1.2),headline3: TextStyle(
            fontSize: 18,
            color: Color(0xFF32A060),
            fontWeight: FontWeight.bold,
          ),headline4: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
      ));
}

const leagues = {
  'silver': Color(0xFFc5d9e7),
  'gold': Color(0xFFfab13b),
  'platnium': Color.fromARGB(255, 51, 53, 62)
};
