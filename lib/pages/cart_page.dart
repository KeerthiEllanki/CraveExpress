import 'package:deliveryapptesting/pages/appdrawer.dart';
import 'package:deliveryapptesting/pages/order_history.dart';
import 'package:deliveryapptesting/pages/restaurant_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/cart_model.dart';
import '../pages/oreder_tracking.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key});

  Future<void> _placeOrder(BuildContext context, CartModel value) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      try {
        CollectionReference users = FirebaseFirestore.instance.collection('users');
        DocumentReference userDoc = users.doc(user.uid);

        // Generate a unique order ID
        String orderId = FirebaseFirestore.instance.collection('orders').doc().id;

        // Prepare order details
        Map<String, dynamic> orderData = {
          'orderId': orderId,
          'timestamp': DateTime.now(),
          'items': value.cartItems.map((item) {
            return {
              'name': item[0],
              'price': item[1],
              'image': item[2],
            };
          }).toList(),
          'totalPrice': value.calculateTotal(),
        };

        // Save order details under user's data
        await userDoc.collection('orders').doc(orderId).set(orderData);

        // Clear cart after placing the order
        value.clearCart();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Order Placed Successfully'),
              content: Text('Your order has been placed successfully!'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrderTrackingPage()),
                    );
                  },
                ),
              ],
            );
          },
        );

        // Show a success message or navigate to the order confirmation page
      } catch (e) {
        print('Error placing order: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CRAVE EXPRESS',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Consumer<CartModel>(
        builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "My Cart",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                    itemCount: value.cartItems.length,
                    padding: EdgeInsets.all(12),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            leading: Image.asset(
                              value.cartItems[index][2],
                              height: 36,
                            ),
                            title: Text(
                              value.cartItems[index][0],
                              style: const TextStyle(fontSize: 18),
                            ),
                            subtitle: Text(
                              '\$' + value.cartItems[index][1],
                              style: const TextStyle(fontSize: 12),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.cancel),
                              onPressed: () =>
                                  Provider.of<CartModel>(context, listen: false)
                                      .removeItemFromCart(index),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(36.0),
                child: GestureDetector(
                  onTap: () => _placeOrder(context, value), // Call _placeOrder function
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.green,
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Price',
                              style: TextStyle(color: Colors.green[200]),
                            ),
                            const SizedBox(height: 8),
                            // total price
                            Text(
                              '\$${value.calculateTotal()}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        // Order Now button
                        GestureDetector(
                          onTap: () async {
                            await _placeOrder(context, value);
                          },
                          // Call _placeOrder function
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green.shade200),
                              borderRadius: BorderRadius.circular(28),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: const [
                                Text(
                                  'Order Now',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // Navigate to Profile Setting Page
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
