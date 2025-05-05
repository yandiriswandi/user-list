import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_list/models/userModel.dart';

import '../services/userServices.dart';

class UserdetailPage extends StatefulWidget {
  const UserdetailPage({super.key, required this.userId});
  final int userId;

  @override
  State<UserdetailPage> createState() => _UserdetailPageState();
}

class _UserdetailPageState extends State<UserdetailPage> {
  final Userservices apiService = Userservices();
  late UserModel user;

  @override
  void initState() {
    super.initState();
    setState(() {});
    fetchData(widget.userId);
  }

  bool isLoading = false;
  Future<void> fetchData(int id) async {
    if (isLoading) return;

    setState(() => isLoading = true);

    try {
      final response = await apiService.fetchUser(id);

      user = response;

      print(response);
    } catch (e) {
      print("Error fetching users: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      body: SafeArea(
        child:
            isLoading
                ? SizedBox(
                  height:
                      MediaQuery.of(context).size.height *
                      0.8, // agar tinggi cukup
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
                : ListView(
                  children: [
                    HeaderContainer(avatar: user.avatar),
                    Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  image: DecorationImage(
                                    image: NetworkImage(user.avatar),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              SizedBox(width: 20),
                              Text(
                                "${user.firstName} ${user.lastName}",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  // fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Text(
                            user.email,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "To build responsibly, tech needs to do more than just hire chief ethics officers",
                            softWrap: true,
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ), // Teks akan dipotong dengan elipsis
                          ),
                          SizedBox(height: 10),
                          Text(
                            "17 June, 2023 — 4:49 PM",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              // fontWeight: FontWeight.w900,
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            width: double.infinity, // Panjang penuh
                            height: 1, // Ketebalan garis
                            color: Colors.grey, // Warna garis
                          ),
                          Text(
                            "In the last couple of years, we’ve seen new teams in tech companies emerge that focus on responsible innovation, digital well-being, AI ethics or humane use. Whatever their titles, these individuals are given the task of “leading” ethics at their companies.",
                            softWrap: true,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.375, // spasi antar baris
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({super.key, required this.avatar});

  final String avatar;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 375,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(avatar), fit: BoxFit.fill),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context); // Kembali ke halaman sebelumnya
            },
            child: Card(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100), // Rounded full
              ),
              child: Padding(
                padding: const EdgeInsets.all(
                  8.0,
                ), // Padding agar ikonnya tidak mepet
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white, // Warna ikon putih
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
