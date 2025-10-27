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
      userId: json['id'].toString(),
      name: json['full_name'].toString(),
      phone: json['phone'].toString(),
      commune: json['commune'].toString(),
      district: json['district'].toString(),
      city: json['city'].toString(),
      role: json['role'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': userId,
      'full_name': name,
      'phone': phone,
      'commune': commune,
      'district': district,
      'city': city,
      'role': role,
    };
  }
}
