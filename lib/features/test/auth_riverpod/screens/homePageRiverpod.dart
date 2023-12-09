import 'package:democrud/features/auth/googlesignup.dart';
import 'package:democrud/features/home/product/addproduct.dart';
import 'package:democrud/features/home/category/categorypage.dart';
import 'package:democrud/features/home/category/tabcategorypage.dart';
import 'package:democrud/features/home/product/tabproductpage.dart';
import 'package:democrud/features/test/category/screens/riverpod_category_page.dart';
import 'package:democrud/features/test/home/screens/first_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';
import '../controller/auth_controller_riverpod.dart';
import 'googlesignupriverpod.dart';


class homePageRiverpod extends ConsumerStatefulWidget {
  const homePageRiverpod({super.key});

  @override
  ConsumerState<homePageRiverpod> createState() => _homePageState();
}

class _homePageState extends ConsumerState<homePageRiverpod> {





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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FirstPageRiverpod(),));
                    },
                    child: Text("Add User")),
                SizedBox(
                  height: w*0.05,
                ),
                ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blueGrey)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RiverpodCategory(),));
                    },
                    child: Text("Add Gender")),
                SizedBox(
                  height: w*0.1,
                ),
                ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blueGrey)),
                    onPressed: () {
                      ref.read(riverpodAuthControllerProvider).signOutRiverpod(context);
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
