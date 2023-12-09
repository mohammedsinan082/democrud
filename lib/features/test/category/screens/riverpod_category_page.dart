import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:democrud/features/test/category/controller/category_controller.dart';
import 'package:democrud/features/test/category/screens/riverpod_view_page.dart';
import 'package:democrud/features/test/home/screens/first_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../main.dart';
import '../../../../model/Constants.dart';
import '../../../../model/categorymodel.dart';
import '../../../home/category/viewcategorypage.dart';

class RiverpodCategory extends ConsumerStatefulWidget {
  const RiverpodCategory({super.key});

  @override
  ConsumerState<RiverpodCategory> createState() => _RiverpodCategoryState();
}

class _RiverpodCategoryState extends ConsumerState<RiverpodCategory> {


  TextEditingController gender_controller=TextEditingController();




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
                controller: gender_controller,
                style: TextStyle(
                  fontSize: w*0.05,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    labelText: "Gender",
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
                  ref.read(CategoryControllerProvider.notifier).addCategory(gender: gender_controller.text);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RiverpodViewPage(),));
                }else{
                  gender_controller.text.isEmpty?showMessage(context, text: "Enter gender", color: Colors.red):
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
