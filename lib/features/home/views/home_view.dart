import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/features/home/data/product_model.dart';
import 'package:hungry_app/features/home/data/product_repo.dart';
import 'package:hungry_app/features/home/widgets/custom_card.dart';
import 'package:hungry_app/features/home/widgets/food_category.dart';
import 'package:hungry_app/features/home/widgets/search_field.dart';
import 'package:hungry_app/features/home/widgets/user_header.dart';
import 'package:hungry_app/features/product/views/product_view.dart';
import 'package:hungry_app/shared/custom_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<String> categories = const ["All", "Combo", "Sliders", "Classic"];
  int selectedIndex = 0;

  final ProductRepo productRepo = ProductRepo();
  bool isLoading = true;
  List<ProductModel> products = [];

  Future<void> getProducts() async {
    final response = await productRepo.getProducts();
    if (mounted) {
      setState(() {
        products = response ?? [];
        isLoading = false;
      });
    }
  }

// Future<void> getProducts() async {
//   setState(() {
//     products = [
//       ProductModel(
//         id: 1,
//         name: "Pizza",
//         image: "assets/test/image6.png",
//         price: "12.99",
//         desc: "Delicious Pizza",
//         rate: "4.5",
//       ),
//       ProductModel(
//         id: 1,
//         name: "Pizza",
//         image: "assets/test/image6.png",
//         price: "12.99",
//         desc: "Delicious Pizza",
//         rate: "4.5",
//       ),
//       ProductModel(
//         id: 1,
//         name: "Pizza",
//         image: "assets/test/image6.png",
//         price: "12.99",
//         desc: "Delicious Pizza",
//         rate: "4.5",
//       ),
//     ];
//     isLoading = false;
//   });
// }

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: getProducts,
          child: Skeletonizer(
            enabled: products.isEmpty && isLoading,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                /// Top Header, Search & Categories
                SliverToBoxAdapter(
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const UserHeader(),
                          const Gap(20),

                          const SearchField(),
                          const Gap(20),

                          /// Promotional Hero Banner
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: AppColors.primaryShadow,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.accentColor,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: const CustomText(
                                          text: "SPECIAL OFFER 20% OFF",
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Gap(8),
                                      const CustomText(
                                        text: "The Ultimate Gourmet Burgers",
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        maxLines: 2,
                                      ),
                                      const Gap(4),
                                      CustomText(
                                        text:
                                            "Order now & get free delivery on your first order",
                                        fontSize: 12,
                                        color: Colors.white.withValues(
                                          alpha: 0.8,
                                        ),
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                                const Gap(12),
                                Image.asset(
                                  "assets/details/pngwing 12.png",
                                  width: 85,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                          ),
                          const Gap(24),

                          /// Category Section Header
                          const CustomText(
                            text: "Categories",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                          const Gap(12),

                          FoodCategory(
                            selectedIndex: selectedIndex,
                            categories: categories,
                          ),
                          const Gap(20),

                          const CustomText(
                            text: "Popular Food",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                          const Gap(12),
                        ],
                      ),
                    ),
                  ),
                ),

                /// GridView of Product Items
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
                  sliver: products.isEmpty && !isLoading
                      ? SliverToBoxAdapter(
                          child: Container(
                            padding: const EdgeInsets.all(40),
                            alignment: Alignment.center,
                            child: Column(
                              children: const [
                                Icon(
                                  CupertinoIcons.square_stack_3d_up,
                                  size: 50,
                                  color: AppColors.textMuted,
                                ),
                                Gap(12),
                                CustomText(
                                  text: "No products available right now",
                                  fontSize: 15,
                                  color: AppColors.textSecondary,
                                ),
                              ],
                            ),
                          ),
                        )
                      : SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            childCount: products.isEmpty ? 4 : products.length,
                            (context, index) {
                              if (products.isEmpty) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                );
                              }
                              final product = products[index];

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ProductDetailsView(),
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
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 14,
                                crossAxisSpacing: 14,
                                childAspectRatio: 0.68,
                              ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
