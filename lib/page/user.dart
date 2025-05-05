import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:user_list/models/userModel.dart';
import 'package:user_list/page/userDetail.dart';
import 'package:user_list/services/userServices.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final Userservices apiService = Userservices();
  final ScrollController _scrollController = ScrollController();

  List<UserModel> users = [];
  int currentPage = 1;
  int totalPage = 1;
  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    if (isLoading || isLastPage) return;

    setState(() => isLoading = true);

    try {
      final response = await apiService.fetchUsers();
      setState(() {
        users.addAll(response);
      });
    } catch (e) {
      print("Error fetching users: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildUserTile(UserModel user) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(user.avatar)),
      title: Text("${user.firstName} ${user.lastName}"),
      subtitle: Text(user.email),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserdetailPage(userId: user.id),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User List')),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: users.length + (isLoading ? 10 : 0),
        itemBuilder: (context, index) {
          if (isLoading) {
            return _buildSkeleton();
          } else {
            return _buildUserTile(users[index]);
          }
        },
      ),
    );
  }
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
