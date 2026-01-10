class PostDetailsModel {
  String? postId;
  final String userId;
  final String title, description;
  final double area, deposit, price;
  final String address, commune, district, city;
  final List<String> image;

  final String? userName;
  final String? userAvatar;
  final String? phoneNumber;

  PostDetailsModel({
    this.postId,
    required this.userId,
    required this.title,
    required this.description,
    required this.area,
    required this.deposit,
    required this.price,
    required this.address,
    required this.commune,
    required this.district,
    required this.city,
    required this.image,
    this.userName,
    this.userAvatar,
    this.phoneNumber,
  });

  factory PostDetailsModel.fromJson(Map<String, dynamic> json) {
    return PostDetailsModel(
      postId: json['id'].toString(),
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
      area: json['area'].toDouble(),
      deposit: json['deposit'].toDouble(),
      price: json['price'].toDouble(),
      address: json['address'],
      commune: json['commune'],
      district: json['district'],
      city: json['city'],
      image: List<String>.from(json['image'] ?? []),

      userName: json['user']?['user_name'],
      userAvatar: json['user']?['avatar'],
      phoneNumber: json['user']?['phone_number'],
    );
  }
}