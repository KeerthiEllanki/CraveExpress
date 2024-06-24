import 'package:flutter/material.dart';
import 'package:deliveryapptesting/components/Restaurant_tile.dart';
import 'package:deliveryapptesting/pages/chikfila_page.dart';
import 'package:deliveryapptesting/pages/chipotle_page.dart';
import 'package:deliveryapptesting/pages/mcdonalds_page.dart';
import 'package:deliveryapptesting/pages/starbucks.dart';
import 'package:provider/provider.dart';
import '../model/cart_model.dart';
import 'appdrawer.dart';
import 'order_history.dart';
import 'oreder_tracking.dart';

class RestPage extends StatefulWidget {
  const RestPage({super.key});

  @override
  State<RestPage> createState() => _RestPageState();
}

class _RestPageState extends State<RestPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRAVE EXPRESS',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          // good morning bro
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text('Checkout your Favourite Restaurant',
                style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold, fontSize: 18.0),
              )// Increase text size
          ),

          const SizedBox(height: 10),

          // Let's order fresh items for you
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Let's order some delicious food",
              style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ),

          const SizedBox(height: 16),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Divider(),
          ),

          const SizedBox(height: 20),

          // categories -> horizontal listview
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Restaurants",
              style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold, fontSize: 12.0),
            ),
          ),

          // recent orders -> show last 3
          Expanded(
            child: Consumer<CartModel>(
              builder: (context, value, child) {
                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.restaurants.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.2,
                  ),
                  itemBuilder: (context, index) {
                    return RestItemTile(
                        itemName: value.restaurants[index][0],
                        imagePath: value.restaurants[index][1],
                        color: value.restaurants[index][2],
                        onPressed: () {
                          if (value.restaurants[index][0] == 'Chick-Fil-A') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
                            );
                          }else if(value.restaurants[index][0] == 'Chipotle'){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage2()),
                            );
                          }else if(value.restaurants[index][0] == 'Mc Donalds'){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage3()),
                            );
                          }else if(value.restaurants[index][0] == 'StarBucks'){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage4()),
                            );
                          }
                        }
                    );
                  },
                );
              },
            ),
          ),
        ],
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
