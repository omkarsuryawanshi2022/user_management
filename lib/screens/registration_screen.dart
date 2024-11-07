import 'package:flutter/material.dart';
import 'package:user_management/core/colors_themes/theme_genarator.dart';
import 'package:user_management/core/local_strings/local_string.dart';
import 'package:user_management/models/user.dart';
import 'package:user_management/viewmodels/user_viewmodel.dart';


class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _viewModel = UserViewModel();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isLargeScreen = screenWidth > 600;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,  // Use extracted color
      appBar: AppBar(
        title: Text(AppStrings.registerTitle, style: TextStyle(color: AppColors.textColor)),
        backgroundColor: AppColors.appBarColor,  // Use extracted color
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
                  AppStrings.welcomeText,
                  style: TextStyle(
                    fontSize: isLargeScreen ? 32 : 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.accentColor,  // Use extracted color
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: AppStrings.usernameLabel,
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
                    labelText: AppStrings.passwordLabel,
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
                      final user = User(
                        username: _usernameController.text,
                        password: _passwordController.text,
                      );
                      await _viewModel.registerUser(user);
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: AppColors.buttonColor,  // Use extracted color
                  ),
                  child: Text(
                    AppStrings.registerButtonText,
                    style: TextStyle(
                        fontSize: isLargeScreen ? 20 : 18, color: AppColors.textColor),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text(
                    AppStrings.alreadyHaveAccountText,
                    style: TextStyle(
                        color: AppColors.textButtonColor,  // Use extracted color
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
