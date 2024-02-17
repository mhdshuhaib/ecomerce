import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tempauth/model/product_model.dart';

class ApiCall {
  // get all products
  Future getProduct() async {
    var dio = Dio();
    var response = await dio.request(
      'https://fakestoreapi.com/products',
      options: Options(
        method: 'GET',
      ),
    );

    List<ProductModel> product = [];

    if (response.statusCode == 200) {
      for (var item in response.data) {
        product.add(ProductModel.fromJson(item));
      }
    }

    return product;
  }
}
