import 'dart:math';

import 'package:deliveryapptesting/pages/appdrawer.dart';
import 'package:deliveryapptesting/pages/order_history.dart';
import 'package:deliveryapptesting/pages/restaurant_page.dart';
import 'package:flutter/material.dart';

class OrderTrackingPage extends StatelessWidget {
  final Random random = Random();

  String generateRandomOrderId({int length = 20}) {
    final random = Random();
    const chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';

    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRAVE EXPRESS',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order ID: ${generateRandomOrderId()}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Estimated Time: 25 minutes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Order Stages:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            OrderStatusTile(
              title: 'Order Placed',
              isCompleted: true,
            ),
            Text(
              'We have received your order',
              style: TextStyle(fontSize: 12, color: Colors.deepOrangeAccent),
            ),
            Divider(),
            OrderStatusTile(
              title: 'Order Confirmed',
              isCompleted: true,
            ),
            Text(
              'Your order has been confirmed',
              style: TextStyle(fontSize: 12, color: Colors.deepOrangeAccent),
            ),
            Divider(),
            OrderStatusTile(
              title: 'Order Processed',
              isCompleted: true,
              isHighlighted: true,
            ),
            Text(
              'We are preparing your order',
              style: TextStyle(fontSize: 12, color: Colors.deepOrangeAccent),
            ),
            Divider(),
            OrderStatusTile(
              title: 'Ready for Pickup',
              isCompleted: false,
            ),
            Text(
              'Your order is ready for pickup',
              style: TextStyle(fontSize: 12, color: Colors.blueGrey),
            ),
            Divider(),
            OrderStatusTile(
              title: 'On the Way',
              isCompleted: false,
            ),
            Text(
              'Your food has been pickedup by the driver and is on the way',
              style: TextStyle(fontSize: 12, color: Colors.blueGrey),
            ),
            Divider(),
            OrderStatusTile(
              title: 'Order Delivered',
              isCompleted: false,
            ),
            Text(
              'Order has been delivered to the customer',
              style: TextStyle(fontSize: 12, color: Colors.blueGrey),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // Navigate to Order Tracking Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RestPage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.track_changes),
              onPressed: () {
                // Navigate to Order Tracking Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderTrackingPage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.history),
              onPressed: () {
                // Navigate to Profile Setting Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderHistory()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                // Navigate to Profile Setting Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppDrawer()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OrderStatusTile extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final bool isHighlighted;

  const OrderStatusTile({
    required this.title,
    required this.isCompleted,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(
            isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isCompleted ? Colors.green : null,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
              color: isHighlighted ? Colors.blue : null,
            ),
          ),
        ),
      ],
    );
  }
}