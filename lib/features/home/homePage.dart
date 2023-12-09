import 'package:democrud/features/auth/googlesignup.dart';
import 'package:democrud/features/home/product/addproduct.dart';
import 'package:democrud/features/home/category/categorypage.dart';
import 'package:democrud/features/home/category/tabcategorypage.dart';
import 'package:democrud/features/home/product/tabproductpage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../test/category/screens/riverpod_category_page.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageRiverpodState();
}

class _homePageRiverpodState extends State<homePage> {

  signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('loginId');
    await GoogleSignIn().signOut().then((value) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => googleSignUp()), (route) => false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: h*0.4,
            width: w*1,
            child: Column(
              children: [
                ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blueGrey)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => producttabpage(),));
                    },
                    child: Text("Add Product")),
                SizedBox(
                  height: w*0.05,
                ),
                ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blueGrey)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RiverpodCategory(),));
                    },
                    child: Text("Add Category")),
                SizedBox(
                  height: w*0.1,
                ),
                ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blueGrey)),
                    onPressed: () {
                      signOut();
                    },
                    child: Text("Sign Out")),
              ],
            ),
          )

        ],
      ),
    );
  }
}
