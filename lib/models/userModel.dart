class UserModel {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  UserModel({
    required this.id,
    required this.email,
    required this.avatar,
    required this.firstName,
    required this.lastName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    email: json["email"],
    avatar: json['avatar'],
    firstName: json['first_name'],
    lastName: json['last_name'],
  );
}

class PaginatedResponse {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<UserModel> users;

  PaginatedResponse({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.users,
  });

  factory PaginatedResponse.fromJson(Map<String, dynamic> json) {
    return PaginatedResponse(
      page: json['page'],
      perPage: json['per_page'],
      total: json['total'],
      totalPages: json['total_pages'],
      users: (json['data'] as List).map((e) => UserModel.fromJson(e)).toList(),
    );
  }
}
