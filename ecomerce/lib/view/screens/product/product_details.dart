import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../model/product_model.dart';
import '../../../utils/constants.dart';
import '../../../viewModel/auth_view_model.dart';
import '../../../viewModel/cart_view_model.dart';
import '../../widgets/padding.dart';
import '../../widgets/text_widgets.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel product;
  const ProductDetails({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartViewModel>(context);
    return Container(
        color: kwhiteColor,
        child: SafeArea(
            child: Scaffold(
          backgroundColor: kwhiteColor,
          body: Column(
            children: [
              appBar(context),
              productImage(),
              const Gap(20),
              productInformations(cart, context),
            ],
          ),
        )));
  }

  // Details of product
  Expanded productInformations(CartViewModel cart, BuildContext context) {
    return Expanded(
      child: Container(
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
          top: 20,
          bottom: 20,
          end: 20,
          start: 20,
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleAndRating(),
              setPadding(
                top: 10,
                bottom: 10,
                widget: textRedHat(
                    text: "Rs ${product.price.toStringAsFixed(2)}",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: kprimaryColor),
              ),
              setPadding(
                bottom: 5,
                widget: textRedHat(
                    text: "Description",
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.black),
              ),
              Expanded(
                child: ListView(
                  children: [
                    setPadding(
                      bottom: 10,
                      widget: textInter(
                          text: product.description,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: kgray),
                    ),
                  ],
                ),
              ),
              addButton(cart,
                  Provider.of<Authentication>(context, listen: false).userId)
            ],
          ),
        ),
      ),
    );
  }

  InkWell addButton(CartViewModel cart, userId) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        if (cart.checkInCart(product)) {
          cart.removeFromCart(product, userId);
        } else {
          cart.addToCart(product, userId);
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        decoration: ShapeDecoration(
          color: cart.checkInCart(product) ? kgray2 : kprimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_bag,
              color: kwhiteColor,
              size: 20,
            ),
            const Gap(10),
            textRedHat(
                text: cart.checkInCart(product)
                    ? "REMOVE FROM CART"
                    : "ADD TO CART",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: kwhiteColor)
          ],
        ),
      ),
    );
  }

  Row titleAndRating() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 235.w,
          child: textInter(
              text: product.title,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            textRedHat(
                text: "⭐ ${product.rating.rate}",
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kmainBlack),
            textRedHat(
                text: " (${product.rating.count})",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: kgray2)
          ],
        ),
      ],
    );
  }

  SizedBox productImage() {
    return SizedBox(
        width: 300.w,
        height: 220.h,
        child: CachedNetworkImage(
          fit: BoxFit.contain,
          imageUrl: product.image,
          placeholder: (context, url) => Container(
            color: kgray3,
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ));
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
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => Navigator.of(context).pop(),
              child: const SizedBox(
                  width: 40, child: Icon(Icons.arrow_back_rounded))),
          textRedHat(
              text: "Details",
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
