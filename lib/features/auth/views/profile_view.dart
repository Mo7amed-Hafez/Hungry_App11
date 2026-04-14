// ignore_for_file: unused_import

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/network/api_error.dart';
import 'package:hungry_app/features/auth/data/auth_model.dart';
import 'package:hungry_app/features/auth/data/auth_repository.dart';
import 'package:hungry_app/features/auth/widgets/custom_user_field.dart';
import 'package:hungry_app/shared/custom_button.dart';
import 'package:hungry_app/shared/custom_text.dart';
import 'package:hungry_app/features/auth/views/login_view.dart';
import 'package:image_picker/image_picker.dart';
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
  bool isLoading = false;

  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getProfileData();

      if (!mounted) return;

      setState(() {
        userModeL = user;

        _nameController.text = user?.name ?? 'User Name';
        _emailController.text = user?.email ?? 'MAFIA@example.com';
        _addressController.text = user?.address ?? 'location as Egypt';
        // _addCreditController.text = user?.visa ?? '**** **** **** ****';
      });
    } catch (e) {
      if (!mounted) return;

      String errorMsg = "Error in Profile";
      if (e is ApiError) {
        errorMsg = e.message;
        print(e.message);
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

  // logic for update profile
  Future<void> updateProfile() async {
    try {
      setState(() => isLoading = true);
      final user = await authRepo.updateProfileData(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        address: _addressController.text.trim(),
        visa: _addCreditController.text.trim().toString(),
        imagePath: selectedImage,
      );
      setState(() => isLoading = false);
      if (!mounted) return;

      setState(() {
        userModeL = user;
      });
      await getProfileData();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomText(text: "Profile Updated", color: Colors.white),
        ),
      );
    } catch (e) {
      setState(() => isLoading = false);
      if (!mounted) return;

      String errorMsg = "Error in Profile";
      if (e is ApiError) {
        errorMsg = e.message;
        print(e.message);
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

  // Logic for Upload image Profile

  String? selectedImage;
  Future<void> uploadImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage.path;
      });
    }
  }

  // Logic for Logout
  bool isLoading2 = false;
  Future<void> logout() async {
    try {
      setState(() => isLoading2 = true);
      await authRepo.logout();
      setState(() => isLoading2 = false);
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      setState(() => isLoading2 = false);
      if (!mounted) return;

      String errorMsg = "Error in Profile";
      if (e is ApiError) {
        errorMsg = e.message;
        print(e.message);
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

  // logic for Guest
  bool isGuest = false;
  Future<void> atoLogin() async {
    final user = await authRepo.autoLogin();
    setState(() => isGuest = authRepo.isGuest);
    if (user != null) {
      setState(() => userModeL = user);
    }
  }

  @override
  void initState() {
    super.initState();
    atoLogin();
    // get profile data from server and set it to controller
    getProfileData();
    // .then((doo) {
    //   _nameController.text = userModeL?.name ?? 'User Name';
    //   _emailController.text = userModeL?.email ?? 'MAFIA@example.com';
    //   _addressController.text = userModeL?.address ?? 'location as Egypt';
    //   _addCreditController.text = userModeL?.visa ?? '**** **** **** ****';
    // });
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
    if (!isGuest) {
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: SingleChildScrollView(
                  // Skeletonizer loading widget while waiting for data from server
                  child: Skeletonizer(
                    enabled: userModeL == null,
                    child: Column(
                      children: [
                        Gap(20),

                        // profile image
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 130,
                              width: 130,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: selectedImage != null
                                      ? FileImage(
                                          File(selectedImage!),
                                        ) // ✅ من الجهاز
                                      : (userModeL?.image != null &&
                                                userModeL!.image!.isNotEmpty
                                            ? NetworkImage(
                                                userModeL!.image!,
                                              ) // ✅ من السيرفر
                                            : AssetImage(
                                                    "assets/images/profile.jpg",
                                                  ) // ✅ default
                                                  as ImageProvider),
                                ),
                              ),
                            ),
                            Positioned(
                              top: -27,
                              right: 0,
                              left: 87,

                              // Edit button for image profile
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.highlight_remove_outlined,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Edit button for image profile
                        Gap(15),
                        CustomButton(
                          title: "Upload Image",
                          onTap: uploadImage,
                          color: Colors.white,
                          textColor: AppColors.primaryColor,
                          width: 150,
                          height: 40,
                          borderRadius: 25,
                          fontWeight: FontWeight.bold,
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
                        userModeL?.visa == null || userModeL!.visa!.isEmpty
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
                                  text: userModeL!.visa!,
                                  // "**** **** **** ****",
                                  color: Colors.black,
                                ),

                                // minLeadingWidth: 100,
                                leading: Image.asset(
                                  "assets/cash/visaLogo.png",
                                  width: 50,
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                          198,
                                          37,
                                          35,
                                          35,
                                        ),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: CustomText(
                                        text: "Default",
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.delete_rounded,
                                        color: Colors.red,
                                        size: 33,
                                      ),
                                    ),
                                  ],
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
                  isLoading // edit button
                      ? CupertinoActivityIndicator(
                          color: AppColors.primaryColor,
                        )
                      : InkWell(
                          onTap: updateProfile,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
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
                  isLoading2 // edit button
                      ? CupertinoActivityIndicator(
                          color: AppColors.primaryColor,
                        )
                      : InkWell(
                          onTap: logout,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
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
    } else if (isGuest) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: "You are A Guest User",
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            Gap(10),
            
            CustomText(
              text: "Please Login",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            Gap(10),
            CustomButton(
              width: 250,
              title: "Login",
              fontWeight: FontWeight.bold,
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      );
    } else {
      return SizedBox(height: 10, width: 10);
    }
  }
}
