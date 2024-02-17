import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:tempauth/services/api.dart';
import '../model/product_model.dart';

class HomeViewModel with ChangeNotifier {
  String selected = 'All';
  bool productFetching = false;
  List<ProductModel> allProduct = [];
  List<ProductModel> filteredProducts = [];

  final List<TabBarModel> listItem = [
    TabBarModel(selected: true, name: 'All'),
    TabBarModel(selected: false, name: "Mens"),
    TabBarModel(selected: false, name: "Womens"),
    TabBarModel(selected: false, name: 'Others'),
  ];

  // update selected value while switching the tab
  void updateSelectedStatus({required String selectedName}) {
    selected = selectedName;
    for (var item in listItem) {
      item.selected = (item.name == selectedName);
    }
    filterProduct();
    notifyListeners();
  }

  // get product from api and filter based on selected tab bar
  Future getProduct() async {
    fetchProduct(true);
    allProduct = await ApiCall().getProduct();
    filterProduct();
    fetchProduct(false);
  }

  // used to filter based on selected category
  void filterProduct() {
    filteredProducts.clear(); // clear existing data
    if (selected == "All") {
      filteredProducts.addAll(allProduct);
    } else if (selected == "Mens") {
      filteredProducts.addAll(
          allProduct.where((product) => product.category == "men's clothing"));
    } else if (selected == "Womens") {
      filteredProducts.addAll(allProduct
          .where((product) => product.category == "women's clothing"));
    } else {
      filteredProducts.addAll(allProduct.where((product) =>
          product.category != "men's clothing" &&
          product.category != "women's clothing"));
    }
  }

  // to manage product fetching
  void fetchProduct(bool val) {
    productFetching = val;
    notifyListeners();
  }
}
