import 'package:democrud/features/home/category/categorypage.dart';
import 'package:democrud/features/home/category/viewcategorypage.dart';
import 'package:flutter/material.dart';

class tabcategorypage extends StatefulWidget {
  const tabcategorypage({super.key});

  @override
  State<tabcategorypage> createState() => _tabcategorypageState();
}

class _tabcategorypageState extends State<tabcategorypage> {
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
                    categorypage(),
                    viewcategorypage(),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
