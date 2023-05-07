import 'package:flutter/material.dart';

import '../screens/products_overview_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProductsOverviewScreen(),
    );
  }
}
