import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hungry_app/features/auth/views/login_view.dart';
import 'package:hungry_app/features/auth/views/profile_view.dart';
import 'package:hungry_app/features/auth/views/singnup_view.dart';
import 'package:hungry_app/features/checkout/views/checkout_view.dart';
import 'package:hungry_app/features/home/views/home_view.dart';
import 'package:hungry_app/features/product/views/product_view.dart';
import 'package:hungry_app/root.dart';
import 'package:hungry_app/splash.dart';

void main() async {

  // علشان الشاشه تفضل بالطول 
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ]
  ); 

  // ⬆️
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hungry App',
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      // home: SingnupView(),

      // Navigator Routes in Flutter in this project
      initialRoute: '/',
      routes: {
        '/': (context) => SplashView(),
        '/login': (context) => LoginView(),
        '/signup': (context) => SingnupView(),
        '/home': (context) => HomeView(),
        '/root': (context) => Root(),
        '/details': (context) => ProductDetailsView(),
        '/profile': (context) => ProfileView(),
        '/checkout': (context) => CheckoutView(),
      },
    );
  }
}
