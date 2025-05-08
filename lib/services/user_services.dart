import 'package:dio/dio.dart';
import '../models/userModel.dart';

Dio dio = Dio();

class Userservices {
  Future<List<UserModel>> fetchUsers() async {
    final response = await dio.get(
      "https://reqres.in/api/users",
      options: Options(headers: {'x-api-key': 'reqres-free-v1'}),
    );

    if (response.statusCode == 200) {
      final data = response.data["data"];
      List<UserModel> users = List.from(
        data.map((user) => UserModel.fromJson(user)),
      );
      return users;
    } else {
      throw Exception("Failed to fetch users");
    }
  }

  Future<UserModel> fetchUser(int id) async {
    final response = await dio.get(
      "https://reqres.in/api/users/$id",
      options: Options(headers: {'x-api-key': 'reqres-free-v1'}),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data["data"]);
    } else {
      throw Exception('Failed to load user');
    }
  }
}
