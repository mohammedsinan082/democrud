import 'package:democrud/features/home/product/addproduct.dart';
import 'package:democrud/features/home/product/viewproduct.dart';
import 'package:flutter/material.dart';

class producttabpage extends StatefulWidget {
  const producttabpage({super.key});

  @override
  State<producttabpage> createState() => _producttabpageState();
}

class _producttabpageState extends State<producttabpage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.white,
          bottom: TabBar(
              indicatorColor: Colors.transparent,
              indicator: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(20),
              ),
              indicatorWeight: 1,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.blueGrey,

              tabs:[
                Tab(
                  text: "add",
                ),
                Tab(
                  text: "Details",
                ),
              ] ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                  children: [
                     addProduct(),
                     productviewpage(),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
