import 'package:flutter/material.dart';
import 'package:greengrocer_course/src/config/custom_colors.dart';

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
          children: [
            Container(color: Colors.red),
            Container(color: Colors.yellow),
            Container(color: Colors.blue),
            Container(color: Colors.purple),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              currentIndex = index;
              pageController.jumpToPage(index);
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