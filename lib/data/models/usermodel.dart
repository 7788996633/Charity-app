class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final int phone;
  final String image;
  // final DateTime? createdDate;
  final String role;
  UserModel({
    required this.id,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.image,
    //  this.createdDate
  });

  factory UserModel.fromJson(data) {
    return UserModel(
      role: data['role'],
      id: data['id'],
      firstName: data['first_name'],
      lastName: data['last_name'],
      email: data['email'],
      phone: data['phone'],
      image: data['image'],
      // createdDate: DateTime.parse(
      //   data['created_at'],
      // ),
    );
  }
}
