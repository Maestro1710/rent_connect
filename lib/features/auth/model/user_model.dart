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
      userId: json['user_id'] as String,
      name: json['user_name'] as String,
      phone: json['phone_number'] as String,
      commune: json['commune'] as String,
      district: json['district'] as String,
      city: json['city'] as String,
      role: json['role'] as String,
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
