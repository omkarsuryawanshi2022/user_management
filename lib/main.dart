import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/login_screen.dart';
import 'screens/user_list_screen.dart';
import 'screens/user_update_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MVVM Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      home: SplashScreen(),
      routes: {
        '/register': (context) => RegistrationScreen(),
        '/login': (context) => LoginScreen(),
        '/userList': (context) => UserListScreen(),
        '/userUpdate': (context) => UserUpdateScreen(),
      },
    );
  }
}
