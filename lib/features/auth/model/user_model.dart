class UserModel {
  final String userId;
  final String name;
  final String phone;
  final String? commune;
  final String? district;
  final String? city;
  final String role;
  final String? avatar;

  UserModel({
    required this.userId,
    required this.name,
    required this.phone,
    required this.commune,
    required this.district,
    required this.city,
    required this.role,
    this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'] as String,
      name: json['user_name'] as String,
      phone: json['phone_number'] as String,
      commune: json['commune'] as String,
      district: json['district'] as String,
      city: json['city'] as String,
      avatar: json['avatar'] as String?,
      role: json['role'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'user_name': name,
      'phone_number': phone,
      'commune': commune,
      'district': district,
      'city': city,
      'avatar': avatar,
      'role': role,
    };
  }

  UserModel copyWith({
    String? userId,
    String? name,
    String? phone,
    String? commune,
    String? district,
    String? city,
    String? role,
    String? avatar,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      commune: commune ?? this.commune,
      district: district ?? this.district,
      city: city ?? this.city,
      role: role ?? this.role,
      avatar: avatar ?? this.avatar,
    );
  }
}
