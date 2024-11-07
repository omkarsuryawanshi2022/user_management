import 'package:flutter/material.dart';
import 'package:user_management/core/colors_themes/theme_genarator.dart';
import 'package:user_management/core/local_strings/local_string.dart';
import 'package:user_management/models/user.dart';
import 'package:user_management/viewmodels/user_viewmodel.dart';


class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final _viewModel = UserViewModel();
  late Future<List<User>> _userListFuture;

  @override
  void initState() {
    super.initState();
    _userListFuture = _viewModel.getUsers();
  }

  void _refreshUserList() {
    setState(() {
      _userListFuture = _viewModel.getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.userListTitle, style: TextStyle(color: AppColors.secondaryColor)),
        backgroundColor: AppColors.primaryColor,
        elevation: 4,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: AppColors.refreshIconColor),
            tooltip: AppStrings.refreshButtonTooltip,
            onPressed: _refreshUserList,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: isLargeScreen ? 40 : 16, vertical: 20),
        child: FutureBuilder<List<User>>(
          future: _userListFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text(AppStrings.errorFetchingUsers + '${snapshot.error}'));
            }

            final users = snapshot.data;
            return ListView.builder(
              itemCount: users!.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: ListTile(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    leading: CircleAvatar(
                      backgroundColor: AppColors.avatarBackgroundColor,
                      child: Icon(Icons.person, color: AppColors.secondaryColor),
                    ),
                    title: Text(
                      user.username,
                      style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.listTileTextColor),
                    ),
                    subtitle: Text(user.password, style: TextStyle(color: AppColors.listTileSubTextColor)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: AppColors.iconColor),
                          tooltip: AppStrings.editButtonTooltip,
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/userUpdate',
                              arguments: user,
                            ).then((_) {
                              _refreshUserList();
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: AppColors.errorColor),
                          tooltip: AppStrings.deleteButtonTooltip,
                          onPressed: () async {
                            await _viewModel.deleteUser(user.id!);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(AppStrings.userDeletedMessage.replaceFirst('{username}', user.username)),
                              backgroundColor: AppColors.snackBarColor,
                            ));
                            _refreshUserList();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
