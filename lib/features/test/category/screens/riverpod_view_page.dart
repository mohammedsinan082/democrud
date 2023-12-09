import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:democrud/features/home/category/categoryeditpage.dart';
import 'package:democrud/features/home/category/categorypage.dart';
import 'package:democrud/features/test/category/controller/category_controller.dart';
import 'package:democrud/features/test/category/screens/riverpod_category_page.dart';
import 'package:democrud/features/test/category/screens/riverpod_edit_page.dart';
import 'package:democrud/model/categorymodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../main.dart';
import '../../../../model/Constants.dart';
import '../../../../model/riverpod_category_model.dart';
import '../../../../model/usermodel.dart';

class RiverpodViewPage extends ConsumerStatefulWidget {
  const RiverpodViewPage({super.key});

  @override
  ConsumerState<RiverpodViewPage> createState() => _RiverpodViewPageState();
}

class _RiverpodViewPageState extends ConsumerState<RiverpodViewPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Consumer(
                builder: (context3, ref3, child3) {
                  return Expanded(
                      child: ref3.watch(viewCategoryProvider).when(
                          data: (categoryList){
                            return ListView.builder(
                                itemCount: categoryList.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context,int index){
                                  CategoryModelRiverpod categoryDetails = categoryList[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      color: Colors.white,
                                      height: 100,
                                      child: Column(
                                        children: [
                                          ListTile(
                                            leading: Text(categoryDetails.gender),
                                              trailing: InkWell(
                                                  onTap: () {
                                                    showDialog(context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Center(child: Text("Are You Sure")),
                                                          actions: [
                                                            InkWell(
                                                              onTap: () {
                                                                var b = categoryDetails.copyWith(
                                                                  delete: true,
                                                                );
                                                                categoryList[index].reference.update(b.toJson());
                                                                Navigator.pop(context);

                                                              },
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                children: [
                                                                  Container(
                                                                    height: 60,
                                                                    width: 60,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(15),
                                                                        color: Colors.blue
                                                                    ),
                                                                    child: Center(child: Text("Yes",style: TextStyle(fontSize: 25,color: Colors.white))),
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      Navigator.pop(context);
                                                                    },
                                                                    child: Container(
                                                                      height: 60,
                                                                      width: 60,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(15),
                                                                          color: Colors.blue
                                                                      ),
                                                                      child: Center(child: Text("No",style: TextStyle(fontSize: 25,color: Colors.white))),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        );
                                                      },);




                                                  },
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Icon(Icons.delete),
                                                      InkWell(
                                                          onTap: () {
                                                            Navigator.push(context, MaterialPageRoute(builder: (context) =>RiverpodEditPage(categoryModelRiverpod: categoryList[index],)));
                                                          },
                                                          child: Icon(Icons.edit))
                                                    ],
                                                  )),

                                            ),





                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          error: (error, stackTrace) => Text(error.toString()),
                          loading: () => Center(child: CircularProgressIndicator()),));
                },

              ),
            ],
          ),
        ));
  }
}
