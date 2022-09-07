import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer_course/src/config/custom_colors.dart';
import 'package:greengrocer_course/src/pages/base/controller/navigation_controller.dart';
import 'package:greengrocer_course/src/pages/cart/view/cart_tab.dart';
import 'package:greengrocer_course/src/pages/orders/view/orders_tab.dart';
import 'package:greengrocer_course/src/pages/profile/profile_tab.dart';

import '../home/view/home_tab.dart';
import 'controller/navigation_controller.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({ Key? key }) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> { 

  final navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: navigationController.pageController,
          children: const [
            HomeTab(),
            CartTab(),
            OrdersTab(),
            ProfileTab()
          ],
        ),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
                  onTap: (index) { 
                      navigationController.navigatePageView(index);
                  },
                  type: BottomNavigationBarType.fixed,
                  currentIndex: navigationController.currentIndex,
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
                )),
      ),
    );
  }
}