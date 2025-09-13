class UserModel {
  final String userId;
  final String name;
  final String phone;
  final String? commune;
  final String? district;
  final String? city;
  final String role;

  UserModel({
    required this.userId,
    required this.name,
    required this.phone,
    required this.commune,
    required this.district,
    required this.city,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'],
      name: json['user_name'],
      phone: json['phone_number'],
      commune: json['commune'],
      district: json['district'],
      city: json['city'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': userId,
      'user_name': name,
      'phone_number': phone,
      'commune': commune,
      'district': district,
      'city': city,
      'role': role,
    };
  }
}
