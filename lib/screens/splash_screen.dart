import 'package:flutter/material.dart';
import 'package:user_management/core/local_assets/comman_images.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Delay for 3 seconds before navigating to the login screen
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });

    return Scaffold(
      body: Center(

        child: Image.asset(LocalAssets.splash_screen ,// Path to your asset image
          fit: BoxFit.cover,  // Optional: Choose how to scale the image
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
