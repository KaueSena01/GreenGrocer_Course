import 'package:flutter/material.dart';
import 'package:greengrocer_course/src/config/custom_colors.dart';
import 'package:greengrocer_course/src/pages/cart/cart_tab.dart';
import 'package:greengrocer_course/src/pages/orders/orders_tab.dart';
import 'package:greengrocer_course/src/pages/profile/profile_tab.dart';

import '../home/view/home_tab.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({ Key? key }) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int currentIndex = 0;
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: const [
            HomeTab(),
            CartTab(),
            OrdersTab(),
            ProfileTab()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              currentIndex = index;
              // pageController.jumpToPage(index);
              pageController.animateToPage(
                index, 
                duration: const Duration(milliseconds: 700), 
                curve: Curves.fastOutSlowIn
              );
            });
          },
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          backgroundColor: CustomColors.customPrimaryColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withAlpha(100),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Carrinho'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Pedidos'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Perfil'
            )
          ],
        ),
      ),
    );
  }
}