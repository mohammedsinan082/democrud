import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:democrud/core/constants/firebase_constants.dart';
import 'package:democrud/features/test/category/screens/riverpod_category_page.dart';
import 'package:democrud/features/test/home/controller/test_controller.dart';
import 'package:democrud/model/riverpod_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../model/riverpod_category_model.dart';
import '../../../home/product/viewproduct.dart';
import '../../../../main.dart';
import '../../../../model/Constants.dart';
import '../../../../model/categorymodel.dart';
import '../../../../model/productmodel.dart';

class SecondPageRiverpod extends ConsumerStatefulWidget {
  const SecondPageRiverpod({super.key});

  @override
  ConsumerState<SecondPageRiverpod> createState() => _SecondPageRiverpodState();
}

class _SecondPageRiverpodState extends ConsumerState<SecondPageRiverpod> {



CategoryModelRiverpod? dropdownvalue;





  final formkey =GlobalKey<FormState>();



  TextEditingController name_controller=TextEditingController();
  TextEditingController age_controller=TextEditingController();




  var imageurl='';
  File? _image;

  pickImage() async {
    final picker=ImagePicker();
    final pickImage= await picker.pickImage(source: ImageSource.gallery,);
    if(pickImage!=null){
      setState(() {
        _image= File(pickImage.path);
      });
      var uploadimage=await FirebaseStorage.instance.ref().child("upload/${DateTime.now()}").putFile(_image!);
      var geturl=await uploadimage.ref.getDownloadURL();
      imageurl=geturl;
      setState(() {
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: w*2.5,
            width: w*1,
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Container(
                    height: w*0.634,
                    width: w*1,
                    // color: colors.secondaryColor,
                    child:Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text("Add image",style: TextStyle(
                                fontSize: w*0.055,fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),),
                            ),

                          ],
                        ),
                        SizedBox(height: w*0.02,),
                        Stack(
                          children: [
                            SizedBox(
                                height: w*0.43,
                                width: w*1,
                                child:imageurl==''?
                                CircleAvatar(

                                  backgroundColor: Colors.blueGrey,
                                  radius: 20,
                                  child: Text("Upload image",style: TextStyle(
                                      color: Colors.white
                                  ),),
                                )
                                    : Center(
                                  child: Container(
                                    height: h*0.26,
                                    width: h*0.26,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(h*0.13),
                                        image: DecorationImage(image:  NetworkImage(imageurl!),fit: BoxFit.contain,)
                                    ),

                                    // child: Image(image: NetworkImage(imageurl!),fit: BoxFit.fitHeight,),

                                  ),
                                )
                            ),
                            Positioned(
                              top: w*0.30,
                              left: w*0.6,
                              child:
                              InkWell(
                                onTap: () {
                                  pickImage();
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: 23,
                                  child: Icon(CupertinoIcons.camera,color: Colors.black,size: w*0.08,),
                                ),
                              ),
                            )

                          ],
                        ),

                      ],
                    ),

                  ),


                  SizedBox(height: w*0.05,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Consumer(
                        builder: (context4, ref4, child4) {
                          return Container(
                            height: w*0.1,
                            width: w*1,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child:
                            ref4.watch(viewCategoryProvider).when(
                                data: (categoryList){
                                  return  DropdownButton(
                                    underline: SizedBox(),
                                    isExpanded: true,
                                    hint: Text("select Category"),
                                    icon: Icon(Icons.keyboard_arrow_down_outlined),
                                    value: dropdownvalue,
                                    items: categoryList.map((e) =>
                                        DropdownMenuItem(
                                            value: e,
                                            child: Text(e.gender,style: TextStyle(
                                                color: Colors.black,
                                                fontSize: w*0.04,
                                                fontWeight: FontWeight.w500
                                            ),))
                                    ).toList() ,
                                    onChanged: (newValue) {
                                      setState(() {
                                        print(newValue);
                                        print("newValue");
                                       dropdownvalue=newValue!;
                                      });
                                    },
                                  );
                                },
                                error: (error, stackTrace) => Text(error.toString()),
                                loading: () => Center(child: CircularProgressIndicator()),)



                          );

                        },

                      )
                    ],
                  ),
                  SizedBox(height: w*0.03,),
                  Container(
                    height: w*0.8,
                    width: w*1,
                    padding: EdgeInsets.all(7),
                    // color: Colors.blue,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                                labelText: "Name",
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: w*0.20,
                              width: w*1,
                              child:TextFormField(
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                //maxLength: 5,
                                // maxLines: null,
                                // minLines: 5,
                                controller: age_controller,
                                style: TextStyle(
                                  fontSize: w*0.05,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                    labelText: "Age",
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

                          ],
                        ),

                      ],
                    ),
                  ),
                  InkWell(
                    onTap: ()  {
                      if(name_controller.text.isNotEmpty&&
                          age_controller.text.isNotEmpty&&
                          imageurl.isNotEmpty
                      ){
                        ref.read(testControllerProvider.notifier).addUser(age: age_controller.text,image: imageurl,name: name_controller.text,category: dropdownvalue!);
                       Navigator.pop(context);
                      }else{
                        name_controller.text.isEmpty?showMessage(context, text: "Enter product Name", color: Colors.red):
                        age_controller.text.isEmpty?showMessage(context, text: "Enter your age", color: Colors.red):
                        showMessage(context, text: "Please upload Image", color: Colors.red);

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
          ),
        ),
      ),
    );

  }
}
