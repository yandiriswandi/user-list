import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:user_list/models/userModel.dart';
import 'package:user_list/services/user_services.dart';

import 'package:get/get.dart';

class UsersController extends GetxController {
  List<UserModel> users = [];
  bool isLoading = false;
  UserModel? user; // Menyimpan user berdasarkan ID

  @override
  void onInit() {
    super.onInit();
    fetchData(); // Ambil data user saat controller diinisialisasi
  }

  // Method untuk mengambil semua user
  Future<void> fetchData() async {
    isLoading = true;
    update(); // Memberitahu GetX untuk memperbarui UI
    try {
      final response = await Userservices().fetchUsers();
      users.addAll(response); // Menambahkan semua user ke dalam list
      update(); // Memberitahu GetX bahwa list telah berubah
    } catch (e) {
      print("Error fetching users: $e");
    } finally {
      isLoading = false;
      update(); // Setel status loading menjadi false dan perbarui UI
    }
  }

  Future<void> fetchUserById(int id) async {
    isLoading = true; // Setel status loading menjadi true
    update(); // Memberitahu GetX untuk memperbarui UI
    try {
      final response = await Userservices().fetchUser(
        id,
      ); // Ambil user berdasarkan ID
      user = response; // Simpan user berdasarkan ID
      update(); // Memberitahu GetX bahwa userById telah berubah
    } catch (e) {
      print("Error fetching user by ID: $e");
    } finally {
      isLoading = false;
      update(); // Setel status loading menjadi false dan perbarui UI
    }
  }
}
