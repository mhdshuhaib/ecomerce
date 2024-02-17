import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:tempauth/view/screens/cart/cart_page.dart';
import 'package:tempauth/viewModel/auth_view_model.dart';
import '../../../utils/constants.dart';
import '../../widgets/logout_confirm.dart';
import '../../widgets/product_card.dart';
import '../../../view/screens/home/select_option.dart';
import '../../../view/widgets/loading.dart';
import '../../../view/widgets/padding.dart';
import '../../../view/widgets/text_widgets.dart';
import '../../../viewModel/cart_view_model.dart';
import '../../../viewModel/home_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () async {
      Provider.of<HomeViewModel>(context, listen: false).getProduct();
      Provider.of<CartViewModel>(context, listen: false).getAllHiveProducts(
          Provider.of<Authentication>(context, listen: false).userId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    var home = Provider.of<HomeViewModel>(context);
    return Container(
      color: kwhiteColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kwhiteColor,
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            appBar(), // cart and log out option
            heading(), // the test before tab bar
            const SelectOption(), // category filter option
            // products gridview
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: home.productFetching ? loading() : productGrid(home),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  GridView productGrid(HomeViewModel home) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.8.h),
      itemCount: home.filteredProducts.length,
      itemBuilder: (BuildContext context, int index) {
        return ProductCard(product: home.filteredProducts[index]);
      },
    );
  }

  Padding heading() {
    return setPadding(
      bottom: 20,
      start: 20,
      widget: textInter(
          text: "Discover products",
          fontSize: 20,
          fontWeight: FontWeight.w300,
          letterSpacing: 1.55,
          color: kmainBlack),
    );
  }

  Padding appBar() {
    var cart = Provider.of<CartViewModel>(context);
    return setPadding(
      start: 20,
      end: 20,
      top: 20,
      bottom: 20,
      widget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => showDialog<String>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) => clearSavePopUp(context)),
            child: Icon(
              Icons.logout,
              color: kgreen200,
            ),
          ),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: const CartPage(),
                  duration: const Duration(milliseconds: 1),
                  reverseDuration: const Duration(milliseconds: 1)),
            ),
            child: SizedBox(
              height: 30,
              width: 30,
              child: Stack(
                children: [
                  Icon(
                    Icons.shopping_cart,
                    color: kgreen200,
                  ),
                  if (cart.cartProduct.isNotEmpty)
                    // show only if product exist in cart
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 16,
                        width: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kprimaryColor,
                        ),
                        child: Center(
                          child: textInter(
                              text: cart.cartProduct.length.toString(),
                              fontSize: 8,
                              fontWeight: FontWeight.w700,
                              color: kwhiteColor),
                        ),
                      ),
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
