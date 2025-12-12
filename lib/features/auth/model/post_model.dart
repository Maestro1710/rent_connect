class PostModel {
  String? postId;
  final String userId;
  final String title, description;
  final double area, deposit, price;
  final String address, commune, district, city;
  final List<String> image;

  PostModel({
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
  });

  factory PostModel.fromJson(Map<String, dynamic> post) {
    return PostModel(
      postId: post['id'].toString(),
      userId: post['user_id'] as String? ?? 'null',
      title: post['title'] as String? ?? 'null',
      description: post['description'] as String? ?? 'null',
      area: (post['area'] as num).toDouble(),
      deposit: (post['deposit'] as num).toDouble(),
      price: (post['price'] as num).toDouble(),
      address: post['address'] as String? ?? 'null',
      commune: post['commune'] as String? ?? 'null',
      district: post['district'] as String? ?? 'null',
      city: post['city'] as String? ?? 'null',
      image: (post['image'] as List).map((e) => e as String).toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': postId,
      'user_id': userId,
      'title': title,
      'description': description,
      'area': area,
      'deposit': deposit,
      'price': price,
      'address': address,
      'commune': commune,
      'district': district,
      'city': city,
      'image': image,
    };
  }
}
