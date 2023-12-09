import 'package:democrud/features/auth/googlesignup.dart';
import 'package:democrud/features/home/category/viewcategorypage.dart';
import 'package:democrud/features/home/homePage.dart';
import 'package:democrud/features/home/product/addproduct.dart';
import 'package:democrud/features/home/category/categorypage.dart';
import 'package:democrud/features/home/product/tabproductpage.dart';
import 'package:democrud/features/home/splashscreen.dart';
import 'package:democrud/features/test/category/screens/riverpod_category_page.dart';
import 'package:democrud/features/test/category/screens/riverpod_view_page.dart';
import 'package:democrud/features/test/home/screens/first_page.dart';
import 'package:democrud/features/test/auth_riverpod/screens/homePageRiverpod.dart';
import 'package:democrud/features/test/auth_riverpod/screens/riverpodsplashscreen.dart';
import 'package:democrud/features/test/home/screens/second_page.dart';
import 'package:democrud/riverpoddemo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var w;
var h;
String currentuserid="";
String currentusername="";
String currentuseremail="";
String currentphonenumber="";
String currentuserimage="";



String riverpodCurrentUserId="";
String riverpodCurrentUserName="";
String riverpodCurrentUserEmail="";
String riverpodCurrentUserNumber="";
String riverpodCurrentUserImage="";



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: myApp()));
}

class myApp extends StatefulWidget {
  const myApp({super.key});

  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    w=MediaQuery.of(context).size.width;
    h=MediaQuery.of(context).size.height;
    return MaterialApp(
      home:splashScreenRiverpod(),
      debugShowCheckedModeBanner: false,
    );
  }
}
