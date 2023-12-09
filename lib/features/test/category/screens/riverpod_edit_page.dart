import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:democrud/features/home/category/viewcategorypage.dart';
import 'package:democrud/features/test/category/screens/riverpod_view_page.dart';
import 'package:democrud/model/riverpod_category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../main.dart';
import '../../../../model/Constants.dart';
import '../../../../model/categorymodel.dart';
import '../controller/category_controller.dart';

class RiverpodEditPage extends ConsumerStatefulWidget {
   final CategoryModelRiverpod categoryModelRiverpod;
  const RiverpodEditPage({super.key, required this.categoryModelRiverpod});

  @override
  ConsumerState<RiverpodEditPage> createState() => _categoryeditpageState();
}

class _categoryeditpageState extends ConsumerState<RiverpodEditPage> {


  TextEditingController gender_controller=TextEditingController();




  @override
  void initState() {
    gender_controller =TextEditingController(text: widget.categoryModelRiverpod.gender);
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
                controller: gender_controller,
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
            SizedBox(height: w*0.4,),
            InkWell(
              onTap: () {
                if(
                gender_controller.text.isNotEmpty
                ){
                  ref.watch(CategoryControllerProvider.notifier).updateCategory(categoryModelRiverpod: widget.categoryModelRiverpod, gender: gender_controller.text.trim());
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RiverpodViewPage(),));
                }else{
                  gender_controller.text.isEmpty? showMessage(context, text: "Update new gender", color: Colors.red):
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
