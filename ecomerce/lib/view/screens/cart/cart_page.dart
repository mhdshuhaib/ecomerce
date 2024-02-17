import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tempauth/viewModel/auth_view_model.dart';

import '../../../utils/constants.dart';
import '../../../viewModel/cart_view_model.dart';
import '../../widgets/padding.dart';
import '../../widgets/text_widgets.dart';
import 'package:tempauth/model/product_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartViewModel>(context);
    String userId = Provider.of<Authentication>(context).userId!;
    return Container(
        color: kwhiteColor,
        child: SafeArea(
            child: Scaffold(
          backgroundColor: kwhiteColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBar(context),
              Expanded(
                  child: cart.cartProduct.isEmpty
                      ? emptyCart()
                      : productList(cart, userId)),
              if (cart.cartProduct.isNotEmpty) proceedButton(cart)
            ],
          ),
        )));
  }

  ListView productList(CartViewModel cart, String userId) {
    return ListView.separated(
      itemCount: cart.cartProduct.length,
      itemBuilder: (BuildContext context, int index) {
        return product(index, context, userId);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: kgray3,
          height: 0.8,
        );
      },
    );
  }

  // Show if cart is empty
  Center emptyCart() {
    return Center(
        child: Column(
      children: [
        Lottie.asset('assets/animations/cart-animation.json',
            repeat: false, fit: BoxFit.fitWidth),
        textRedHat(
            text: "No products added",
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: kmainBlack),
      ],
    ));
  }

  Container proceedButton(CartViewModel cart) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: kgray3.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20.0),
          topLeft: Radius.circular(20.0),
        ),
        border: Border.all(color: kgray3),
      ),
      child: setPadding(
        start: 20,
        end: 20,
        top: 20,
        bottom: 20,
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textRedHat(
                    text: "Total",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textRedHat(
                    text: "Rs ${cart.totalAmount.toStringAsFixed(2)}",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: kprimaryColor),
              ],
            ),
            const Gap(20),
            Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                decoration: ShapeDecoration(
                  color: kprimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.r),
                  ),
                ),
                child: Center(
                  child: textRedHat(
                      text: "PROCEED TO BUY",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: kwhiteColor),
                )),
          ],
        ),
      ),
    );
  }

  // cart product view
  Padding product(int index, context, userId) {
    var product = Provider.of<CartViewModel>(context).cartProduct[index];
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              image(product),
            ],
          ),
          const Gap(10),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title(product, context, userId),
              const Gap(10),
              priceAndQty(product, context, userId)
            ],
          )
        ],
      ),
    );
  }

  // price and qty section
  Widget priceAndQty(ProductModel product, context, userId) {
    var cart = Provider.of<CartViewModel>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 150.w,
          child: textRedHat(
              text: "Rs ${product.price.toStringAsFixed(2)}",
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kprimaryColor),
        ),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => cart.removeQty(product, userId),
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kgray3,
            ),
            child: Center(
              child: Icon(
                Icons.remove,
                color: kgray,
                size: 18,
              ),
            ),
          ),
        ),
        const Gap(10),
        textRedHat(
            text: product.qty.toString(),
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black),
        const Gap(10),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => cart.addQty(product, userId),
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kprimaryColor,
            ),
            child: const Center(
              child: Icon(
                Icons.add,
                color: kwhiteColor,
                size: 18,
              ),
            ),
          ),
        )
      ],
    );
  }

  Row title(ProductModel product, context, userId) {
    var cart = Provider.of<CartViewModel>(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 200.w,
          height: 50,
          child: textRedHat(
              text: product.title,
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: kmainBlack),
        ),
        InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => cart.removeFromCart(product, userId),
            child: const Icon(Icons.close))
      ],
    );
  }

  Container image(ProductModel product) {
    return Container(
      width: 100,
      height: 100,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.50, color: Color(0xFFC4C9C6)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: CachedNetworkImage(
          fit: BoxFit.contain,
          imageUrl: product.image,
          placeholder: (context, url) => Container(
            color: kgray3,
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }

  Padding appBar(BuildContext context) {
    return setPadding(
      start: 10,
      end: 20,
      top: 20,
      bottom: 30,
      widget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: const SizedBox(
                  width: 30, child: Icon(Icons.arrow_back_rounded))),
          textRedHat(
              text: "Cart",
              fontSize: 18,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.2,
              color: Colors.black),
          const SizedBox()
        ],
      ),
    );
  }
}
