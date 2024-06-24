import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class RestItemTile extends StatelessWidget {
  final String itemName;
  final String imagePath;
  final color;
  void Function()? onPressed;

  RestItemTile({
    super.key,
    required this.itemName,
    required this.imagePath,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color[100],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // item image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Image.asset(
                imagePath,
                height: 60,
              ),
            ),

            // item name

            MaterialButton(
              onPressed: onPressed,
              color: color,
              child: Text(
                itemName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
