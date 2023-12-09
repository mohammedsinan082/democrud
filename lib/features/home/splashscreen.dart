import 'package:democrud/features/auth/googlesignup.dart';
import 'package:democrud/features/home/homePage.dart';
import 'package:democrud/features/images/images.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {

  loggedinCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.containsKey('loginId')){
      String? loginId = prefs.getString('loginId');

        Navigator.push(context, MaterialPageRoute(builder: (context) => homePage()));
    }
    else{
        Navigator.push(context, MaterialPageRoute(builder: (context) => googleSignUp()));
    }


  }

  void initState(){

    Future.delayed(Duration(seconds: 1),() {
      loggedinCheck();
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
