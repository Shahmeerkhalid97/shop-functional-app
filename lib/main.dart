import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_functional_app/screens/add_product_screen.dart';
import 'package:shop_functional_app/screens/user_product_screen.dart';

import './screens/home_screens.dart';
import './screens/product_details_screen.dart';
import './screens/cart_detail_screen.dart';
import './screens/orders_detail_screen.dart';

import 'providers/products_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/order_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductsProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.deepOrange),
          fontFamily: 'Lato',
        ),
        home: const HomeScreen(),
        routes: {
          ProductDetailsScreen.routeName: (context) =>
              const ProductDetailsScreen(),
          CartDetailScreen.routeName: (context) => const CartDetailScreen(),
          OrderDetailScreen.routeName: (context) => const OrderDetailScreen(),
          UserProductScreen.routeName: (context) => const UserProductScreen(),
          AddProductScreen.routeName: (context) => const AddProductScreen(),
        },
      ),
    );
  }
}
