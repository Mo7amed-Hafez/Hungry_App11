# hungry_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


هنا كل ما يخص الكود و تنظيم الملفات و الاكواد 
file structure

lib/
 core/  
  constants/
  api_endpoints.dart
  app_colors.dart
  app_stringes.dart

 network/
  api_service.dart
  api_exceptions.dart

 utils/
  helpers.dart
  validators.dart

 features/
  food/

   1 data/
    food_model.dart
    food_repository.dart


  2 view/
    food_list_view.dart
    food_detail_view.dart


  3 widgets/
     food_card.dart

   4 cubit 
     هنا فيما بعد ممكن تضيف State Mangement
     لكن في المشروع دا مش هيكون فيه 

     في كل feature هيكون فيه من 1 2 3 اساسي 

splash.dart
root.dart
main.dart