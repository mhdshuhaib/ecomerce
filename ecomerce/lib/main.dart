import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'db/product_db.dart';
import 'view/screens/splash_screen.dart';
import 'viewModel/auth_view_model.dart';
import 'viewModel/cart_view_model.dart';
import 'viewModel/home_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(MyApp());
  Hive.registerAdapter(HiveProductAdapter());
  Hive.registerAdapter(HiveProductListAdapter());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ScreenUtilInit(
              designSize: const Size(360, 800),
              minTextAdapt: true,
              splitScreenMode: false,
              builder: (context, child) {
                return MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                        create: (context) => Authentication()),
                    ChangeNotifierProvider(
                        create: (context) => HomeViewModel()),
                    ChangeNotifierProvider(
                        create: (context) => CartViewModel()),
                  ],
                  child: MaterialApp(
                    title: 'Shopping Mart',
                    debugShowCheckedModeBanner: false,
                    home: SplashScreen(),
                  ),
                );
              });
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
