import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/features/home/data/product_model.dart';
import 'package:hungry_app/features/home/data/product_repo.dart';
import 'package:hungry_app/features/home/widgets/custom_card.dart';
import 'package:hungry_app/features/home/widgets/food_category.dart';
import 'package:hungry_app/features/home/widgets/search_field.dart';
import 'package:hungry_app/features/home/widgets/user_header.dart';
import 'package:hungry_app/features/product/views/product_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List categories = ["All", "Combo", "Sliders", "Classic"];

  int selectedIndex = 0;

  // logic for get Products
  ProductRepo productRepo = ProductRepo();

  bool isLoading = true;
  List<ProductModel>  products = []; // علشان نخزن فيها اللي جاي من الداتا
  Future<void> getProducts() async {
    final response = await productRepo.getProducts();
    setState(() {
      products = response ?? [];
    });
  }

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Skeletonizer(
        enabled: products.isEmpty,
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
                    childCount: products.length, // عدد العناصر

                    (context, index) {
                      final product = products[index];
                      // ignore: dead_code
                      if (products.isEmpty || product == null) {
                        return CupertinoActivityIndicator();
                      }
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
                          image: product.image,
                          title: product.name,
                          desc: product.desc,
                          rate: product.rate,
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
      ),
    );
  }
}
