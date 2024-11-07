import 'package:flutter/material.dart';
import 'package:user_management/core/colors_themes/theme_genarator.dart';
import 'package:user_management/core/local_strings/local_string.dart';
import 'package:user_management/models/user.dart';
import 'package:user_management/viewmodels/user_viewmodel.dart';


class UserUpdateScreen extends StatefulWidget {
  @override
  _UserUpdateScreenState createState() => _UserUpdateScreenState();
}

class _UserUpdateScreenState extends State<UserUpdateScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _viewModel = UserViewModel();
  late User _user;

  @override
  Widget build(BuildContext context) {
    /// Retrieve the user object passed as an argument to this screen
    _user = ModalRoute.of(context)!.settings.arguments as User;
    _usernameController.text = _user.username;
    _passwordController.text = _user.password;

    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600; // Check if it's a larger screen like a tablet or web

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.updateUserTitle, style: TextStyle(color: AppColors.secondaryTextColor)),
        backgroundColor: AppColors.primaryColor,
        elevation: 4,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: isLargeScreen ? 40 : 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.updateUserInfo,
              style: TextStyle(
                fontSize: isLargeScreen ? 24 : 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: AppStrings.usernameLabel,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                filled: true,
                fillColor: AppColors.fillColor,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: AppStrings.passwordLabel,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                filled: true,
                fillColor: AppColors.fillColor,
              ),
              obscureText: true,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                final updatedUser = User(
                  id: _user.id,
                  username: _usernameController.text,
                  password: _passwordController.text,
                );
                await _viewModel.updateUser(updatedUser);
                Navigator.pushReplacementNamed(context, '/userList');
              },
              child: Text(AppStrings.updateButton, style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14),
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await _viewModel.deleteUser(_user.id!);
                Navigator.pushReplacementNamed(context, '/userList');
              },
              child: Text(AppStrings.deleteButton, style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14),
                backgroundColor: AppColors.secondaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
