import 'package:flutter/material.dart';
import 'package:practica2/src/screens/login_screen.dart';
import 'package:practica2/src/utils/color_settings.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashSreen extends StatelessWidget {
  const SplashSreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: LoginScreen(),
      duration: 5000,
      imageSrc: 'assets/logo_itc.png',
      imageSize: 150,
      text: 'Bienvenidos',
      backgroundColor: ColorsSettings.colorPrimary,
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
      colors: [Colors.blue, Colors.green, Colors.orange, Colors.red],
    );
  }
}
