import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:user_list/controllers/user_controller.dart';
import 'package:user_list/models/userModel.dart';
import 'package:user_list/page/user_detail.dart';

class UserPage extends StatelessWidget {
  var usersC = Get.put(UsersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User List', style: GoogleFonts.poppins())),
      body: GetBuilder(
        init: usersC,
        builder:
            (context) => ListView.builder(
              itemCount: usersC.users.length + (usersC.isLoading ? 10 : 0),
              itemBuilder: (context, index) {
                if (usersC.isLoading) {
                  return _buildSkeleton();
                } else {
                  return _buildUserTile(context, usersC.users[index]);
                }
              },
            ),
      ),
    );
  }

  Widget _buildUserTile(BuildContext context, UserModel user) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage(user.avatar)),
          title: Text(
            "${user.firstName} ${user.lastName}",
            style: GoogleFonts.poppins(),
          ),
          subtitle: Text(user.email, style: GoogleFonts.poppins()),
          onTap: () {
            usersC.fetchUserById(user.id);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserDetailPage()),
            );
          },
        ),

        Padding(
          padding: const EdgeInsets.only(right: 15, left: 15),
          child: Divider(thickness: 1, height: 0),
        ),
      ],
    );
  }

  Widget _buildSkeleton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Row(
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: Colors.grey[700]!,
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 20.0, color: Colors.grey[100]!),
                  SizedBox(height: 8),
                  Container(width: 100, height: 20.0, color: Colors.grey[100]!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
