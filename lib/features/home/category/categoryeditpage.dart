import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:democrud/features/home/category/viewcategorypage.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../model/Constants.dart';
import '../../../model/categorymodel.dart';
import '../../test/category/screens/riverpod_view_page.dart';

class categoryeditpage extends StatefulWidget {
   final CategoryModel categoryModel;
  const categoryeditpage({super.key, required this.categoryModel});

  @override
  State<categoryeditpage> createState() => _categoryeditpageState();
}

class _categoryeditpageState extends State<categoryeditpage> {


  TextEditingController name_controller=TextEditingController();
  TextEditingController description_controller=TextEditingController();


  addCategory(){
    int id =Timestamp.now().seconds;

    DocumentReference ref = FirebaseFirestore.instance.collection(Constants.category).doc(widget.categoryModel.id);
    final product =widget.categoryModel.copyWith(
      name: name_controller.text ?? "",
      id: ref.id ?? '',
      date:DateTime.now(),
      delete: false,
      reference: ref,
      description: description_controller.text ?? "",


    );
    ref.update(product.toJson());
    name_controller.clear();
    description_controller.clear();
    showMessage(context, text: "Category Updated...", color: Colors.green);
  }


  @override
  void initState() {
    name_controller =TextEditingController(text: widget.categoryModel.name);
    description_controller =TextEditingController(text: widget.categoryModel.description);
    super.initState();
  }
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
                    labelText: "Product Name",
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RiverpodViewPage(),));
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
