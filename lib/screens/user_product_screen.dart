import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/user_products_item.dart';
import '../widgets/app_drawer.dart';

import '../screens/add_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({super.key});
  static const routeName = '/user-product';

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AddProductScreen.routeName);
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: productData.items.length,
            itemBuilder: (ctx, i) => Column(
                  children: [
                    UserProductsItem(
                      productId: productData.items[i].id,
                      title: productData.items[i].title,
                      imageUrl: productData.items[i].imageUrl,
                    ),
                    const Divider(),
                  ],
                )),
      ),
      drawer: const AppDrawer(),
    );
  }
}
