import 'package:hive_flutter/adapters.dart';
part 'product_db.g.dart';

@HiveType(typeId: 1)
class HiveProduct extends HiveObject {
  @HiveField(0)
  String? userId;

  @HiveField(1)
  List<HiveProductList>? products;

  HiveProduct({required this.userId, required this.products});
}

@HiveType(typeId: 2)
class HiveProductList extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  double? price;

  @HiveField(3)
  String? description;

  @HiveField(4)
  String? category;

  @HiveField(5)
  String? image;

  @HiveField(6)
  int? qty;

  HiveProductList(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image,
      required this.qty});
}
