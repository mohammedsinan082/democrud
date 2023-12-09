import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:democrud/features/home/category/viewcategorypage.dart';
import 'package:democrud/model/categorymodel.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../model/Constants.dart';

class categorypage extends StatefulWidget {
  const categorypage({super.key});

  @override
  State<categorypage> createState() => _categorypageState();
}

class _categorypageState extends State<categorypage> {


  TextEditingController name_controller=TextEditingController();
  TextEditingController description_controller=TextEditingController();


  addCategory(){
    int id =Timestamp.now().seconds;

    DocumentReference ref = FirebaseFirestore.instance.collection(Constants.category).doc("Category$id");
    final product =CategoryModel(
        name: name_controller.text ?? "",
        id: ref.id ?? '',
        date:DateTime.now(),
        delete: false,
        reference: ref,
        description: description_controller.text ?? "",


    );
    ref.set(product.toJson());
    name_controller.clear();
    description_controller.clear();
    showMessage(context, text: "Category Added...", color: Colors.green);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: w*0.08,
            ),
            Container(
              height: w*0.20,
              width: w*1,
              child:TextFormField(
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.sentences,
                //maxLength: 5,
                // maxLines: null,
                // minLines: 5,
                controller: name_controller,
                style: TextStyle(
                  fontSize: w*0.05,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    labelText: "Category Name",
                    labelStyle: TextStyle(
                      fontSize: w*0.05,
                      color: Colors.grey,
                    ),
                    hintStyle: TextStyle(
                      fontSize: w*0.05,
                      color: Colors.grey,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w*0.03),
                        borderSide:BorderSide(
                          color: Colors.blueGrey,
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w*0.03),
                        borderSide:BorderSide(
                          color: Colors.blueGrey,
                        )
                    )
                ),
              ),
            ),
            SizedBox(height: w*0.05,),
            Container(
              height: w*0.20,
              width: w*1,
              child: TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.sentences,
                //maxLength: 5,
                // maxLines: null,
                // minLines: 5,
                controller: description_controller,
                style: TextStyle(
                  fontSize: w*0.05,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    labelText: "Description",
                    labelStyle: TextStyle(
                      fontSize: w*0.05,
                      color: Colors.grey,
                    ),
                    hintStyle: TextStyle(
                      fontSize: w*0.05,
                      color: Colors.grey,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w*0.03),
                        borderSide:BorderSide(
                            color: Colors.blueGrey
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w*0.03),
                        borderSide:BorderSide(
                          color: Colors.blueGrey,
                        )
                    )
                ),
              ),
            ),
            SizedBox(height: w*0.4,),
            InkWell(
              onTap: () {
                if(
                name_controller.text.isNotEmpty&&
                description_controller.text.isNotEmpty
                ){
                  addCategory();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => viewcategorypage(),));
                }else{
                  name_controller.text.isEmpty?showMessage(context, text: "Enter Category Name", color: Colors.red):
                  name_controller.text.isEmpty?showMessage(context, text: "Enter Description", color: Colors.red):
                  showMessage(context, text: "Complete your field", color: Colors.red);
                }

              },
              child: Container(
                height: w*0.13,
                width: w*0.95,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(w*0.02),
                ),
                child: Center(child: Text("ADD",style:
                TextStyle(
                    fontSize: w*0.070,color: Colors.white
                ),)),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
