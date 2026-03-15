// ignore_for_file: unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/network/api_error.dart';
import 'package:hungry_app/features/auth/data/auth_model.dart';
import 'package:hungry_app/features/auth/data/auth_repository.dart';
import 'package:hungry_app/features/auth/widgets/custom_user_field.dart';
import 'package:hungry_app/shared/custom_text.dart';
import 'package:hungry_app/features/auth/views/login_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _addCreditController = TextEditingController();

  // Logic for Profile
  UserModeL? userModeL; // for user data from api server
  AuthRepo authRepo = AuthRepo();

  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getProfileData();
      setState(() {
        userModeL = user; // علشان نعرف نستخدمه في ال ui
      });
    } catch (e) {
      String errorMsg = "Error in Profile";
      if (e is ApiError) {
        errorMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomText(text: errorMsg, color: Colors.white),
          backgroundColor: const Color.fromARGB(255, 191, 64, 55),
          elevation: 15,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // get profile data from server and set it to controller
    getProfileData().then((doo) {
      _nameController.text = userModeL?.name ?? 'User Name';
      _emailController.text = userModeL?.email ?? 'MAFIA@example.com';
      _addressController.text = userModeL?.address ?? 'location as Egypt';
      _addCreditController.text = userModeL?.visa ?? '**** **** **** ****';
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: const Color.fromARGB(246, 157, 149, 160),
      color: AppColors.primaryColor,
      onRefresh: () async {
        await getProfileData();
      },

      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.primaryColor,
          appBar: AppBar(
            toolbarHeight: 35,
            bottomOpacity: 0,
            scrolledUnderElevation: 0,
            backgroundColor: AppColors.primaryColor,

            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings, color: Colors.white),
              ),
            ],
          ),

          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SingleChildScrollView(
                child: Skeletonizer(
                  enabled: userModeL == null,
                  child: Column(
                    children: [
                      Gap(20),

                      // profile image
                      Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          image:
                              userModeL?.image != null &&
                                  userModeL!.image!.isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(userModeL!.image!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                      ),
                      Gap(40),

                      // user data
                      // name
                      CustomUserField(
                        controller: _nameController,
                        lableTitle: "Name",
                      ),
                      Gap(20),

                      // email
                      CustomUserField(
                        controller: _emailController,
                        lableTitle: "Email",
                      ),
                      Gap(20),

                      // address
                      CustomUserField(
                        controller: _addressController,
                        lableTitle: "Address",
                      ),
                      Gap(20),

                      // credit card
                      Divider(color: Colors.white),
                      Gap(20),

                      // add credit card
                      userModeL?.visa == null
                          ? CustomUserField(
                              controller: _addCreditController,
                              lableTitle: "Add Credit Card",
                              textType: TextInputType.number,
                            )
                          : ListTile(
                              tileColor: Color(0xffeff1f3),
                              title: Text(
                                "Debit Card",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),

                              subtitle: CustomText(
                                text:
                                    userModeL?.visa.toString() ??
                                    "**** **** **** ****",
                                color: Colors.black,
                              ),

                              leading: Image.asset(
                                "assets/cash/visaLogo.png",
                                width: 50,
                              ),
                              trailing: CustomText(
                                text: "Default",
                                color: Colors.black,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 3,
                              ),
                            ),
                      Gap(300),
                    ],
                  ),
                ),
              ),
            ),
          ),

          bottomSheet: Container(
            height: 80,
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 146, 142, 142),
                  blurRadius: 2,
                  offset: Offset(0, -3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // edit button
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.primaryColor,
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        CustomText(
                          text: "Edit Profile",
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        Gap(10),
                        Icon(Icons.edit_square, color: Colors.white),
                      ],
                    ),
                  ),
                ),

                // Logout button
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.transparent,
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        CustomText(
                          text: "Logout",
                          fontSize: 18,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        Gap(10),
                        Icon(
                          Icons.login_outlined,
                          color: AppColors.primaryColor,
                        ),
                      ],
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
