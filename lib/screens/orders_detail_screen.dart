import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_functional_app/widgets/app_drawer.dart';

import '../providers/order_provider.dart' show OrderProvider;
import '../widgets/order_item.dart';

class OrderDetailScreen extends StatelessWidget {
  static const routeName = '/order-details';
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, index) => OrderItem(orderData.orders[index]),
      ),
      drawer: const AppDrawer(),
    );
  }
}
