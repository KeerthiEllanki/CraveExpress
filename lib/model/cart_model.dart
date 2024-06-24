import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  // list of items on sale


  final List _restaurants = const [
    // [ itemName, imagePath, color ]
    ["Chick-Fil-A",  "lib/images/restaurants/chick-fil-a.png", Colors.green],
    ["Chipotle",  "lib/images/restaurants/chipotle.png", Colors.yellow],
    ["Mc Donalds",  "lib/images/restaurants/mcdonalds.png", Colors.brown],
    ["StarBucks",  "lib/images/restaurants/starbucks.png", Colors.blue],
  ];

  final List _chickfilaItems = const [
    // [ itemName, itemPrice, imagePath, color ]
    ["Chicken Nuggets", "4.00", "lib/images/chickfila/Chicken_Nuggets.jpeg", Colors.green],
    ["Peppermint Chip Milkshake", "12.80", "lib/images/chickfila/Peppermint_Chip_Milkshake.jpeg", Colors.brown],
    ["Chicken Tortilla Soup", "2.50", "lib/images/chickfila/Chicken_Tortilla_Soup.jpeg", Colors.yellow],
    ["Spicy Chicken Burger", "1.00", "lib/images/chickfila/spicy_chicken_burger.jpeg", Colors.blue],
  ];

  final List _chipotleItems = const [
    // [ itemName, itemPrice, imagePath, color ]
    ["Burito", "4.00", "lib/images/chipotle/Burito.jpeg", Colors.green],
    ["Quesadilla", "2.50", "lib/images/chipotle/Quesadilla.jpeg", Colors.yellow],
    ["Salad", "12.80", "lib/images/chipotle/Salad.jpeg", Colors.brown],
    ["Tacos", "1.00", "lib/images/chipotle/Tacos.jpeg", Colors.blue],
  ];

  final List _mcdItems = const [
    // [ itemName, itemPrice, imagePath, color ]
    ["Cappuccino", "4.00", "lib/images/mcdonalds/Cappuccino.jpeg", Colors.green],
    ["Egg McMuffin", "2.50", "lib/images/mcdonalds/Egg_McMuffin.jpeg", Colors.yellow],
    ["Hamburger Happy Meal", "12.80", "lib/images/mcdonalds/Hamburger_Happy_Meal.jpeg", Colors.brown],
    ["World Famous Fries", "1.00", "lib/images/mcdonalds/World_Famous_Fries.jpeg", Colors.blue],
  ];

  final List _starbucksItems = const [
    // [ itemName, itemPrice, imagePath, color ]
    ["Horizon Chocolate Organic Milk", "4.00", "lib/images/starbucks/Horizon_Chocolate_Organic_Milk.jpeg", Colors.green],
    ["Iced Sugar Cookie Almondmilk Latte", "2.50", "lib/images/starbucks/Iced_Sugar_Cookie_Almondmilk_Latte.jpeg", Colors.yellow],
    ["Lemonade", "12.80", "lib/images/starbucks/Lemonade.jpeg", Colors.brown],
    ["Vanilla Cream", "1.00", "lib/images/starbucks/Vanilla_Creme.jpeg", Colors.blue],
  ];
  // list of cart items
  List _cartItems = [];

  get cartItems => _cartItems;


  get restaurants => _restaurants;

  get chickfilaItems => _chickfilaItems;

  get chipotleItems => _chipotleItems;

  get mcdItems => _mcdItems;

  get starbucksItems => _starbucksItems;


  // add item to cart
  void addItemToCart1(int index) {
    _cartItems.add(_chickfilaItems[index]);
    notifyListeners();
  }
  void addItemToCart2(int index) {
    _cartItems.add(_chipotleItems[index]);
    notifyListeners();
  }
  void addItemToCart3(int index) {
    _cartItems.add(_mcdItems[index]);
    notifyListeners();
  }
  void addItemToCart4(int index) {
    _cartItems.add(_starbucksItems[index]);
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }


  // calculate total price
  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < cartItems.length; i++) {
      totalPrice += double.parse(cartItems[i][1]);
    }
    return totalPrice.toStringAsFixed(2);
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
