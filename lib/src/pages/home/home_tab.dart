import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greengrocer_course/src/config/custom_colors.dart';
import 'package:greengrocer_course/src/pages/common_widgets/app_name_widget.dart';
import 'package:greengrocer_course/src/pages/common_widgets/custom_shimmer.dart';
import 'package:greengrocer_course/src/pages/home/components/item_tile.dart';
import 'package:greengrocer_course/src/services/utils_services.dart';
import 'components/category_tile.dart';
import 'package:greengrocer_course/src/config/app_data.dart' as app_data;

class HomeTab extends StatefulWidget {
  const HomeTab({ Key? key }) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  final UtilServices utilServices = UtilServices();
  
  String selectedCategory = 'Frutas';

  GlobalKey<CartIconKey> globalKeyCartItems = GlobalKey<CartIconKey>();

  late Function(GlobalKey) runAddToCartAnimation;

  void itemSelectedCartAnimation(GlobalKey gkImage) {
    runAddToCartAnimation(gkImage);
  }

  bool isLoading = true; 

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 750), () {
      setState(() {
        isLoading = !isLoading;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const AppNameWidget(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0, right: 15.0),
            child: GestureDetector(
              onTap: () {},
              child: Badge(
                badgeColor: CustomColors.customContrastColor,
                badgeContent: const Text("2", style: TextStyle(color: Colors.white, fontSize: 14)),
                child: AddToCartIcon(
                  key: globalKeyCartItems,
                  icon: Icon(Icons.shopping_cart, color: CustomColors.customPrimaryColor)
                )
              ),
            ),
          )
        ],
      ),
      body: AddToCartAnimation(
        gkCart: globalKeyCartItems ,
        previewDuration: const Duration(milliseconds: 100),
        previewCurve: Curves.ease,
        receiveCreateAddToCardAnimationMethod: (addToCartAnimationMethod) {
          runAddToCartAnimation = addToCartAnimationMethod;
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  hintText: 'Pesquise aqui',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14
                  ),
                  prefixIcon: Icon(Icons.search, color: CustomColors.customContrastColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none
                    )
                  )
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 25),
              height: 40,
              child: !isLoading ? ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return CategoryTile(
                    onPressed: () {
                      setState(() {
                        selectedCategory = app_data.categories[index];
                      });
                    },
                    category: app_data.categories[index],
                    isSelected: app_data.categories[index] == selectedCategory,
                  );
                }, 
                separatorBuilder: (_, index) => const SizedBox(width: 10),
                itemCount: app_data.categories.length
              ) :
              ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  app_data.categories.length, (index) => 
                  Container(
                    margin: const EdgeInsets.only(right: 12),
                    alignment: Alignment.center,
                    child: CustomShimmer(
                      height: 20, 
                      width: 80,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  )
                )
              )
            ),
            Expanded(
              child: !isLoading ? GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 9 / 11.5
                ),
                itemCount: app_data.items.length,
                itemBuilder: (_, index) {
                  return ItemTile(
                    item: app_data.items[index],
                    cartAnimationMethod: itemSelectedCartAnimation
                  );
                },
              ) : 
              GridView.count(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                physics: const BouncingScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 9 / 11.5,
                  children: List.generate(
                    app_data.items.length, (index) => 
                    CustomShimmer(
                      height: double.infinity, 
                      width: double.infinity,
                      borderRadius: BorderRadius.circular(20),
                    )
                )
              )
            )
          ],
        ),
      ),
    );
  }
}