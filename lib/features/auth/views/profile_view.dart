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

  UserModeL? userModeL;
  AuthRepo authRepo = AuthRepo();
  bool isLoading = false;
  bool isLoading2 = false;
  bool isGuest = false;
  String? selectedImage;

  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getProfileData();

      if (!mounted) return;

      setState(() {
        userModeL = user;
        _nameController.text = user?.name ?? 'User Name';
        _emailController.text = user?.email ?? 'MAFIA@example.com';
        _addressController.text = user?.address ?? 'location as Egypt';
      });
    } catch (e) {
      if (!mounted) return;

      String errorMsg = "Error loading profile";
      if (e is ApiError) {
        errorMsg = e.message;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: CustomText(text: errorMsg, color: Colors.white),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Future<void> updateProfile() async {
    try {
      setState(() => isLoading = true);
      final user = await authRepo.updateProfileData(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        address: _addressController.text.trim(),
        visa: _addCreditController.text.trim(),
        imagePath: selectedImage,
      );

      if (!mounted) return;
      setState(() {
        isLoading = false;
        userModeL = user;
      });

      await getProfileData();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: AppColors.success,
          content: const CustomText(text: "Profile updated successfully!", color: Colors.white),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoading = false);

      String errorMsg = "Error updating profile";
      if (e is ApiError) {
        errorMsg = e.message;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: CustomText(text: errorMsg, color: Colors.white),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

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

  Future<void> logout() async {
    try {
      setState(() => isLoading2 = true);
      await authRepo.logout();

      if (!mounted) return;
      setState(() => isLoading2 = false);
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoading2 = false);

      String errorMsg = "Error logging out";
      if (e is ApiError) {
        errorMsg = e.message;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: CustomText(text: errorMsg, color: Colors.white),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Future<void> atoLogin() async {
    final user = await authRepo.autoLogin();
    if (!mounted) return;
    setState(() {
      isGuest = authRepo.isGuest;
      if (user != null) {
        userModeL = user;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    atoLogin();
    getProfileData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _addCreditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isGuest) {
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.borderLight, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primarySoft,
                    ),
                    child: const Icon(
                      CupertinoIcons.lock_shield_fill,
                      size: 48,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const Gap(20),
                  const CustomText(
                    text: "Guest User Account",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  const Gap(8),
                  const CustomText(
                    text: "Sign in to manage your profile, saved cards, and track live orders.",
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                  ),
                  const Gap(24),
                  CustomButton(
                    width: double.infinity,
                    title: "Sign In Now",
                    icon: CupertinoIcons.arrow_right,
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return RefreshIndicator(
      color: AppColors.primaryColor,
      onRefresh: getProfileData,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: Skeletonizer(
            enabled: userModeL == null,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                /// Gradient Header Container with Avatar
                SliverToBoxAdapter(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
                    decoration: const BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
                    ),
                    child: Column(
                      children: [
                        const CustomText(
                          text: "My Profile",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        const Gap(20),

                        /// Profile Avatar Stack
                        Stack(
                          children: [
                            Container(
                              height: 110,
                              width: 110,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 3),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.2),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: selectedImage != null
                                      ? FileImage(File(selectedImage!))
                                      : (userModeL?.image != null && userModeL!.image!.isNotEmpty
                                          ? NetworkImage(userModeL!.image!)
                                          : const AssetImage("assets/images/profile.jpg")
                                              as ImageProvider),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: uploadImage,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: AppColors.accentColor,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    CupertinoIcons.camera_fill,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(12),

                        CustomText(
                          text: userModeL?.name ?? "Loading...",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        const Gap(2),
                        CustomText(
                          text: userModeL?.email ?? "",
                          fontSize: 13,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ],
                    ),
                  ),
                ),

                /// Profile Input Fields & Payment Options
                SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      const CustomText(
                        text: "Personal Details",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      const Gap(14),

                      CustomUserField(
                        controller: _nameController,
                        lableTitle: "Full Name",
                        prefixIcon: CupertinoIcons.person,
                      ),
                      const Gap(14),

                      CustomUserField(
                        controller: _emailController,
                        lableTitle: "Email Address",
                        prefixIcon: CupertinoIcons.mail,
                      ),
                      const Gap(14),

                      CustomUserField(
                        controller: _addressController,
                        lableTitle: "Delivery Address",
                        prefixIcon: CupertinoIcons.location,
                      ),
                      const Gap(24),

                      const CustomText(
                        text: "Saved Payment Cards",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      const Gap(14),

                      userModeL?.visa == null || userModeL!.visa!.isEmpty
                          ? CustomUserField(
                              controller: _addCreditController,
                              lableTitle: "Add Credit / Debit Card Number",
                              textType: TextInputType.number,
                              prefixIcon: CupertinoIcons.creditcard,
                            )
                          : Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: AppColors.borderLight),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.03),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 46,
                                    height: 34,
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Image.asset(
                                      "assets/cash/visaLogo.png",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const Gap(14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const CustomText(
                                          text: "Debit Card",
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimary,
                                        ),
                                        const Gap(2),
                                        CustomText(
                                          text: userModeL!.visa!,
                                          fontSize: 13,
                                          color: AppColors.textSecondary,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primarySoft,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const CustomText(
                                      text: "Default",
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      const Gap(100),
                    ]),
                  ),
                ),
              ],
            ),
          ),

          /// Bottom Floating Actions Sheet
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 20,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: isLoading
                        ? const Center(child: CupertinoActivityIndicator())
                        : CustomButton(
                            height: 50,
                            title: "Save Changes",
                            icon: CupertinoIcons.floppy_disk,
                            onTap: updateProfile,
                          ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: isLoading2
                        ? const Center(child: CupertinoActivityIndicator())
                        : CustomButton(
                            height: 50,
                            title: "Log Out",
                            color: Colors.white,
                            textColor: AppColors.error,
                            borderColor: AppColors.error.withValues(alpha: 0.3),
                            icon: CupertinoIcons.arrow_right_square,
                            onTap: logout,
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
