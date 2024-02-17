import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import '../db/product_db.dart';
import '../model/product_model.dart';

class CartViewModel with ChangeNotifier {
  List<ProductModel> cartProduct = [];
  double totalAmount = 0.0;
  final String boxName = 'product';

  void addToCart(ProductModel product, String userId) async {
    product.qty = 1;
    cartProduct.add(product);
    calulateTotal();
    await productToHiveClass(
      userId: userId,
      product: product,
      type: "add",
    );
    notifyListeners();
  }

  void removeFromCart(ProductModel product, String userId) async {
    cartProduct.remove(product);
    await deleteProduct(userId, product.id);
    calulateTotal();
    notifyListeners();
  }

  // to check the product is exist in cart
  bool checkInCart(ProductModel product) {
    return cartProduct.contains(product);
  }

  void addQty(ProductModel product, String userId) async {
    ProductModel item = cartProduct.firstWhere(
      (element) => element.id == product.id,
    );
    item.qty += 1;
    await productToHiveClass(
        userId: userId,
        product: item,
        type: "qty update",
        productId: product.id);
    calulateTotal();
    notifyListeners();
  }

  void removeQty(ProductModel product, userId) async {
    ProductModel item = cartProduct.firstWhere(
      (element) => element.id == product.id,
    );
    if (item.qty == 1) {
      cartProduct.remove(product);
      await deleteProduct(userId, product.id);
    } else {
      item.qty -= 1;
      await productToHiveClass(
          userId: userId,
          product: item,
          type: "qty update",
          productId: product.id);
    }
    calulateTotal();
    notifyListeners();
  }

  void calulateTotal() {
    totalAmount = 0.0;
    for (var product in cartProduct) {
      totalAmount += product.price * product.qty;
    }
    notifyListeners();
  }

  // Local storage box opening
  Future<Box<HiveProduct>> get _box async => await Hive.openBox(boxName);

  // Get all products from the HiveProductList based on userId
  Future getAllHiveProducts(String userId) async {
    try {
      log(userId.toString());
      final box = await _box;
      var hiveProduct =
          box.values.firstWhere((element) => element.userId == userId);
      if (hiveProduct.products != null) {
        for (var item in hiveProduct.products!) {
          cartProduct.add(ProductModel(
              id: item.id!,
              title: item.title!,
              price: item.price!,
              description: item.description!,
              category: item.category!,
              image: item.image!,
              rating: Rating(rate: 0, count: 0),
              qty: item.qty!));
        }
      }
    } catch (e) {
      print('Failed to get all products: $e');
    }
    calulateTotal();
    notifyListeners();
  }

  // converting cart item to local storage class
  Future productToHiveClass(
      {required String? userId,
      required String? type,
      required ProductModel product,
      int? productId}) async {
    HiveProductList hiveProduct = HiveProductList(
        id: product.id,
        title: product.title,
        price: product.price,
        description: product.description,
        category: product.category,
        image: product.image,
        qty: product.qty);

    if (type == "add") {
      await addProduct(userId!, hiveProduct);
    } else if (type == 'qty update') {
      await updateProduct(userId!, productId!, hiveProduct);
    }
  }

  // Add a new product to the HiveProductList based on userId
  Future addProduct(String userId, HiveProductList product) async {
    try {
      final box = await _box;
      // Checking if the user is already in hive
      var hiveProduct = box.values.firstWhere(
          (element) => element.userId == userId,
          orElse: () => HiveProduct(userId: "not exist", products: []));

      if (hiveProduct.userId != 'not exist') {
        // If HiveProduct exists for the userId, add the product to it
        hiveProduct.products?.add(product);
        await hiveProduct.save();
      } else {
        // If HiveProduct does not exist for the userId, create a new one and add the product
        var newHiveProduct = HiveProduct(userId: userId, products: [product]);
        await box.add(newHiveProduct);
      }
    } catch (e) {
      print('Failed to add product: $e');
    }
  }

  // Update an existing product in the HiveProductList based on userId
  Future updateProduct(
      String userId, int productId, HiveProductList updatedProduct) async {
    try {
      final box = await _box;

      var hiveProduct =
          box.values.firstWhere((element) => element.userId == userId);
      if (hiveProduct.products != null) {
        var index = hiveProduct.products!
            .indexWhere((product) => product.id == productId);
        // If product exist
        if (index != -1) {
          hiveProduct.products![index] = updatedProduct;
          await hiveProduct.save();
        }
      }
    } catch (e) {
      print('Failed to update product: $e');
    }
  }

  // Delete a product from the HiveProductList based on userId and productId
  Future<void> deleteProduct(String userId, int productId) async {
    try {
      final box = await _box;
      var hiveProduct =
          box.values.firstWhere((element) => element.userId == userId);
      if (hiveProduct.products != null) {
        hiveProduct.products!.removeWhere((product) => product.id == productId);
        await hiveProduct.save();
      }
    } catch (e) {
      print('Failed to delete product: $e');
    }
  }
}
