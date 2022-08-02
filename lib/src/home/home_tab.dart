import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:greengrocer_course/src/config/custom_colors.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text.rich(
          TextSpan(
            style: const TextStyle(
              fontSize: 30
            ),
            children: [
              TextSpan(text: 'Green', style: TextStyle(
                color: CustomColors.customPrimaryColor
              )),
              TextSpan(text: 'grocer', style: TextStyle(
                color: CustomColors.customContrastColor
              )),
            ]
          )
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0, right: 15.0),
            child: GestureDetector(
              onTap: () {},
              child: Badge(
                badgeColor: CustomColors.customContrastColor,
                badgeContent: const Text("2", style: TextStyle(color: Colors.white, fontSize: 14)),
                child: Icon(Icons.shopping_cart, color: CustomColors.customPrimaryColor)
              ),
            ),
          )
        ],
      ),
    );
  }
}