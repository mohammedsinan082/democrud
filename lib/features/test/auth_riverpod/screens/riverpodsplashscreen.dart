import 'package:democrud/features/auth/googlesignup.dart';
import 'package:democrud/features/home/homePage.dart';
import 'package:democrud/features/images/images.dart';
import 'package:democrud/features/test/auth_riverpod/screens/googlesignupriverpod.dart';
import 'package:democrud/features/test/auth_riverpod/screens/homePageRiverpod.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';


class splashScreenRiverpod extends StatefulWidget {
  const splashScreenRiverpod({super.key});

  @override
  State<splashScreenRiverpod> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashScreenRiverpod> {

  loggedinCheckriverpod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.containsKey('loginidriverpod')){
      String? loginIdriverpod = prefs.getString('loginidriverpod');

        Navigator.push(context, MaterialPageRoute(builder: (context) => homePageRiverpod()));
    }
    else{
        Navigator.push(context, MaterialPageRoute(builder: (context) => googleSignUpRiverpod()));
    }


  }

  void initState(){

    Future.delayed(Duration(seconds: 1),() {
      loggedinCheckriverpod();
      });



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: w*2.2,
        width: w*1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: w*0.6,
              width: w*0.6,
              // color: Colors.yellow,
              child: Image.asset(Pictures.icon),
            )
          ],
        ),
      ),

    );
  }
}
