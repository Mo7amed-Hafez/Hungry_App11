import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/features/home/widgets/custom_card.dart';
import 'package:hungry_app/features/home/widgets/food_category.dart';
import 'package:hungry_app/features/home/widgets/search_field.dart';
import 'package:hungry_app/features/home/widgets/user_header.dart';
import 'package:hungry_app/features/product/views/product_view.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List categories = ["All", "Combo", "Sliders", "Classic"];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            // AppBar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Gap(50),

                    /// Header
                    UserHeader(),
                    Gap(20),

                    /// Search
                    SearchField(),
                    Gap(40),

                    /// Categories
                    FoodCategory(
                      selectedIndex: selectedIndex,
                      categories: categories,
                    ),

                    Gap(30),
                  ],
                ),
              ),
            ),

            // GridView for items
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  childCount: 6, // عدد العناصر

                  (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsView(),
                          ),
                        );
                      },
                      child: CardItem(
                        image: 'assets/test/image 6.png',
                        title: "Burger King",
                        desc: "fast food with a lot of cheese and meat and a lot of cheese and meat",
                        rate: "4.5",
                      ),
                    );
                  },
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
