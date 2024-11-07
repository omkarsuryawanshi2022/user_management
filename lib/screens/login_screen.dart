import 'package:flutter/material.dart';
import 'package:user_management/core/colors_themes/theme_genarator.dart';
import 'package:user_management/core/local_strings/local_string.dart';
import 'package:user_management/viewmodels/user_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _viewModel = UserViewModel();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isLargeScreen = screenWidth > 600;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title:
            Text(AppStrings.loginTitle, style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.appBarColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isLargeScreen ? screenWidth * 0.2 : 16.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppStrings.welcomeBack,
                  style: TextStyle(
                    fontSize: isLargeScreen ? 32 : 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: AppStrings.username,
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: AppStrings.password,
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  obscureText: _obscurePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.03),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final isValid = await _viewModel.loginUser(
                        _usernameController.text,
                        _passwordController.text,
                      );
                      if (isValid) {
                        Navigator.pushReplacementNamed(context, '/userList');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(AppStrings.invalidCredentials),
                          backgroundColor: AppColors.errorSnackBarColor,
                        ));
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: AppColors.buttonColor,
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: isLargeScreen ? 20 : 18, color: Colors.white),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text(
                    AppStrings.registerPrompt,
                    style: TextStyle(
                        color: AppColors.buttonColor,
                        fontSize: isLargeScreen ? 18 : 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
