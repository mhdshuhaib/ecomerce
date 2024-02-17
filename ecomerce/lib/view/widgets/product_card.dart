import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:tempauth/view/screens/product/product_details.dart';
import '../../model/product_model.dart';
import '../../utils/constants.dart';
import '../../viewModel/auth_view_model.dart';
import '../../viewModel/cart_view_model.dart';
import 'padding.dart';
import 'text_widgets.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartViewModel>(context);
    String userId = Provider.of<Authentication>(context, listen: false).userId!;
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft,
            child: ProductDetails(product: product),
            duration: const Duration(milliseconds: 1),
            reverseDuration: const Duration(milliseconds: 1)),
      ),
      child: Container(
        width: 165.w,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 0.50, color: Color(0xFFC4C9C6)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // image container
              setPadding(
                top: 10,
                bottom: 10,
                widget: SizedBox(
                  width: 80.w,
                  height: 80.w,
                  child: CachedNetworkImage(
                    fit: BoxFit.contain,
                    imageUrl: product.image,
                    placeholder: (context, url) => Container(
                      color: kgray3,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              // product name
              SizedBox(
                width: 160.w,
                child: textRedHat(
                    text: product.title,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: kmainBlack),
              ),
              const Gap(5),
              // rating
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  textRedHat(
                      text: "⭐ ${product.rating.rate}",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: kmainBlack),
                  textRedHat(
                      text: " (${product.rating.count})",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: kgray2)
                ],
              ),
              const Gap(5),
              // price and add to cart
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textRedHat(
                      text: "Rs ${product.price.toStringAsFixed(2)}",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kprimaryColor),
                  InkWell(
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
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            cart.checkInCart(product) ? kprimaryColor : kgray3,
                      ),
                      child: Center(
                        child: Icon(
                          cart.checkInCart(product) ? Icons.remove : Icons.add,
                          color:
                              cart.checkInCart(product) ? kwhiteColor : kgray,
                          size: 18,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
