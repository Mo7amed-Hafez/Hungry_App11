// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/features/auth/widgets/custom_user_field.dart';
import 'package:hungry_app/shared/custom_text.dart';
import 'package:hungry_app/features/auth/views/login_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = 'Mohamed Hafez';
    _emailController.text = 'mohamed@gmail.com';
    _addressController.text = 'Zagazig Egypt';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          scrolledUnderElevation: 0,
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
            child: Column(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white, width: 4),
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://photodpshare.com/wp-content/uploads/2025/10/cool-profile-pictures-for-boys-nice-5k-full-576x1024.png"
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Gap(40),
                CustomUserField(
                  controller: _nameController,
                  lableTitle: "Name",
                ),
                Gap(20),
                CustomUserField(
                  controller: _emailController,
                  lableTitle: "Email",
                ),
                Gap(20),
                CustomUserField(
                  controller: _addressController,
                  lableTitle: "Address",
                ),
                Gap(20),
                Divider(color: Colors.white),
                Gap(20),
                ListTile(
                  tileColor: Color(0xffeff1f3),
                  title: Text(
                    "Debit Card",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: CustomText(
                    text: "35** **** **** 0505",
                    color: Colors.black,
                  ),
                  leading: Image.asset("assets/cash/visaLogo.png", width: 50),
                  trailing: CustomText(text: "Default", color: Colors.black),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
     
      bottomSheet: Container(
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 146, 142, 142),
              blurRadius: 2,
              offset: Offset(0, -3),
            ),
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // edit button
            InkWell(
              onTap: () {
                
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.primaryColor,
                  border: Border.all(
                    color: AppColors.primaryColor,
                    width: 2
                  )
                ),
                child: Row(
                  children: [
                    CustomText(text: "Edit Profile",fontSize: 18 ,color: Colors.white,fontWeight: FontWeight.bold,),
                    Gap(10),
                    Icon(Icons.edit_square, color: Colors.white,)
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
                    width: 2
                  )
                ),
                child: Row(
                  children: [
                    CustomText(text: "Logout",fontSize: 18 ,color: AppColors.primaryColor,fontWeight: FontWeight.bold,),
                    Gap(10),
                    Icon(Icons.login_outlined, color: AppColors.primaryColor)
                  ],
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
