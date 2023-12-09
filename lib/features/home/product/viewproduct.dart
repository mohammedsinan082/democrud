import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:democrud/features/home/product/producteditpage.dart';
import 'package:democrud/model/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../main.dart';
import '../../../model/Constants.dart';
import '../../../model/usermodel.dart';

class productviewpage extends StatefulWidget {
  const productviewpage({super.key});

  @override
  State<productviewpage> createState() => _productviewpageState();
}

class _productviewpageState extends State<productviewpage> {

  getDetails(){
    return FirebaseFirestore.instance.collection("product")
        .where("delete",isEqualTo: false)
        .orderBy("date",descending: true)
        .snapshots().map((event) => event.docs.map((e) => ProductModel.fromJson(e.data())).toList());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<ProductModel>>(
                  stream:FirebaseFirestore.instance.collection("product")
                      .where('delete',isEqualTo: false)
                      .orderBy("date",descending: true)
                      .snapshots().map((event) => event.docs.map((e) => ProductModel.fromJson(e.data())).toList()),
                  builder: (context, snapshot) {
                    print(snapshot);
                    print(snapshot.error);
                    if(!snapshot.hasData){
                      return const Center(child: CircularProgressIndicator(),);
                    }
                    List<ProductModel> details =snapshot.data!;
                    print("++++++++++++++++");
                    print(details);
                    print("*******************");
                    // print(details[0]);
                    return details.length == 0 ? Text("No data"):ListView.builder(
                        itemCount: details.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context,int index){
                          ProductModel userDetails = details[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: InkWell(
                              onTap: (){
                                // var a = userDetails.copyWith(
                                //   delete: true,
                                // );
                                //
                                //
                                // details[index].reference.update(a.toJson());


                              },
                              child:
                                ListTile(
                                  leading: Stack(
                                    children: [
                                      userDetails.available==false?Container(
                                        child: Column(
                                          children: [
                                            Text("Not"),
                                            Text("Available"),
                                          ],
                                        ),
                                      ):Image(image: NetworkImage(userDetails.image))
                                    ],
                                  ),
                                  title:   Column(
                                    children: [
                                      Text(userDetails.prdctName),
                                      Text(userDetails.amount.toString()),
                                      Text(userDetails.description),
                                    ],
                                  ),
                                  trailing: SizedBox(
                                    width: w*0.2,
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
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(Icons.delete),
                                            InkWell(
                                                onTap: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => producteditpage(productModel: userDetails),));
                                                },
                                                child: Icon(Icons.edit))
                                          ],
                                        )),
                                  ),

                                )


                            ),
                          );
                        });
                  }
              ),
            ),
          ],
        ));
  }
}
