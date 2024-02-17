class TabBarModel {
  bool selected;
  String name;

  TabBarModel({
    required this.selected,
    required this.name,
  });
}

// product model
class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rating rating;
  int qty = 1;

  ProductModel(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image,
      required this.rating,
      required this.qty});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json["id"],
      title: json["title"] ?? '',
      price: json["price"]?.toDouble(),
      description: json["description"] ?? '',
      category: json["category"] ?? '',
      image: json["image"] ?? '',
      rating: Rating.fromJson(json["rating"]),
      qty: 1);
}

class Rating {
  final double rate;
  final int count;

  Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"]?.toDouble(),
        count: json["count"],
      );
}
