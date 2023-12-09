
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:democrud/features/test/home/controller/test_controller.dart';
import 'package:democrud/features/test/home/screens/second_page.dart';
import 'package:democrud/model/riverpod_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../main.dart';
import 'edit_page.dart';

class FirstPageRiverpod extends StatelessWidget {
  const FirstPageRiverpod({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPageRiverpod(),));
          }, child: Icon(Icons.add)),



          Consumer(
            builder: (context1,ref1,child1) {
              return Expanded(
                child: ref1.watch(viewUserProvider).when(
                    data: (userList) {
                      return ListView.builder(
                          itemCount: userList.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context,int index){
                            RiverpodModel userDetails = userList[index];
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
                                          Image(image: NetworkImage(userDetails.imageurl))
                                        ],
                                      ),
                                      title:   Column(
                                        children: [
                                          Text(userDetails.category),
                                          Text(userDetails.name),
                                          Text(userDetails.age),
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
                                                          userList[index].reference.update(a.toJson());
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
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage(riverpodModel: userList[index],)));
                                                    },
                                                    child: Icon(Icons.edit))
                                              ],
                                            )),
                                      )


                                  ),
                                ));
                          });
                    },
                    error: (error, stackTrace) => Center(child: Text(error.toString())),
                    loading: () => Center(child: CircularProgressIndicator(),),
                ),
              );
            }
          ),


        ],
      ),
    );
  }
}
