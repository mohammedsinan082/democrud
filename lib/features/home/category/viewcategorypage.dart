import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:democrud/features/home/category/categoryeditpage.dart';
import 'package:democrud/model/categorymodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../main.dart';
import '../../../model/Constants.dart';
import '../../../model/usermodel.dart';

class viewcategorypage extends StatefulWidget {
  const viewcategorypage({super.key});

  @override
  State<viewcategorypage> createState() => _viewcategorypageState();
}

class _viewcategorypageState extends State<viewcategorypage> {


   getDetails()   {
    return FirebaseFirestore.instance.collection(Constants.category)
        .where("delete",isEqualTo: false)
        .orderBy("date",descending: true)
        .snapshots().map((event) => event.docs.map((e) => CategoryModel.fromJson(e.data())).toList());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<List<CategoryModel>>(
                    stream: getDetails(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData){
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      List<CategoryModel> details =snapshot.data!;
                      return ListView.builder(
                          itemCount: details.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context,int index){
                            CategoryModel userDetails = details[index];
                            return InkWell(
                              onTap: (){
                                // var a = userDetails.copyWith(
                                //   delete: true,
                                // );
                                //
                                //
                                // details[index].reference.update(a.toJson());


                              },
                              child: Container(
                                color: Colors.white,
                                height: 120,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Column(
                                        children: [
                                          Text(DateFormat("dd-MMM-yyyy hh:mm a").format(userDetails.date)),
                                          Text(userDetails.name),
                                          Text(userDetails.description),
                                        ],
                                      ),
                                      trailing: SizedBox(
                                        width: w*0.02,
                                        child: InkWell(
                                            onTap: () {
                                              showDialog(context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Center(child: Text("Are You Sure")),
                                                    actions: [
                                                      InkWell(
                                                        onTap: () {
                                                          var a = userDetails.copyWith(
                                                            delete: true,
                                                          );
                                                          details[index].reference.update(a.toJson());
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
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => categoryeditpage(categoryModel: userDetails),));
                                                    },
                                                    child: Icon(Icons.edit))
                                              ],
                                            )),
                                      ),
                                    )





                                  ],
                                ),
                              ),
                            );
                          });
                    }
                ),
              ),
            ],
          ),
        ));
  }
}
