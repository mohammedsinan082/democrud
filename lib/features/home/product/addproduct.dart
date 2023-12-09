import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:democrud/features/home/product/viewproduct.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../main.dart';
import '../../../model/Constants.dart';
import '../../../model/categorymodel.dart';
import '../../../model/productmodel.dart';

class addProduct extends StatefulWidget {
  const addProduct({super.key});

  @override
  State<addProduct> createState() => _addProductState();
}

class _addProductState extends State<addProduct> {

  var dropdownvalue;
  List <CategoryModel> category=[];
  bool toggle=false;

  getCategory() async {
    QuerySnapshot snapshot=await FirebaseFirestore.instance.collection(Constants.category)
        .where("delete",isEqualTo: false).get();
    if(snapshot.docs.isNotEmpty){
      category.clear();
      for(DocumentSnapshot doc in snapshot.docs){
        category.add((CategoryModel.fromJson(doc.data())));
      }
    }
    if(mounted){
      setState(() {

      });
    }
  }


  addProduct(){
    int id =Timestamp.now().seconds;

    DocumentReference ref = FirebaseFirestore.instance.collection(Constants.product).doc("FLIT$id");
    final product =ProductModel(
        image: imageurl ?? "",
        prdctName: name_controller.text??'',
        amount: double.tryParse(price_controller.text)??0,
        delete: false,
        description: description_controller.text??'',
        id: ref.id,
        reference: ref,
        date: DateTime.now(),
        category:dropdownvalue,
        available: toggle,
    );
    ref.set(product.toJson());
    name_controller.clear();
    price_controller.clear();
    description_controller.clear();
    imageurl='';
    toggle=false;
    dropdownvalue=null;
    showMessage(context, text: "Product Added...", color: Colors.green);
    setState(() {

    });
  }


  final formkey =GlobalKey<FormState>();




  TextEditingController name_controller=TextEditingController();
  TextEditingController price_controller=TextEditingController();
  TextEditingController description_controller=TextEditingController();


  bool check1=false;


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
  void initState() {
    getCategory();
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
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
                InkWell(
                  onTap: () {
                    toggle=!toggle;
                    setState(() {

                    });
                  },
                  child: Container(
                    height: w*0.085,
                    width: w*0.17,
                    decoration: BoxDecoration(
                        color: toggle?Colors.green:Colors.black12,
                        borderRadius: BorderRadius.circular(w*0.2),
                        border: Border.all(
                            color: Colors.black45
                        )
                    ),
                    child: Stack(
                      children: [
                        AnimatedPositioned(
                          curve:Curves.linear,
                          right: toggle?w*0:w*0.085,
                          left: toggle?w*0.085:w*0,
                          duration: Duration(milliseconds: 300),
                          child: AnimatedContainer(
                            curve: Curves.easeInOut,
                            height: w*0.085,
                            width: w*0.085,
                            decoration: BoxDecoration(
                                color: Colors.white,shape: BoxShape.circle
                            ),
                            duration:Duration(milliseconds: 300) ,

                          ),
                        ),
                        toggle?   AnimatedPositioned(
                          right: toggle?w*0.085:w*0,
                          top: w*0.02,
                          duration:Duration(milliseconds: 500),
                          child: Text("ON"),

                        ):

                        AnimatedPositioned(
                          left: toggle?w*0:w*0.085,
                          top: w*0.02,
                          duration:Duration(milliseconds: 500),
                          child: Text("OFF"),

                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: w*0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: w*0.1,
                      width: w*1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child:DropdownButton(
                        underline: SizedBox(),
                        isExpanded: true,
                        hint: Text("select Category"),
                        icon: Icon(Icons.keyboard_arrow_down_outlined),
                        value: dropdownvalue,
                        items: category.map((e) =>
                            DropdownMenuItem(
                                value: e.name,
                                child: Text(e.name,style: TextStyle(
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
                        },),


                    )
                  ],
                ),

                SizedBox(height: w*0.05,),
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
                              controller: price_controller,
                              style: TextStyle(
                                fontSize: w*0.05,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                  labelText: "Product Price",
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

                      Column(
                        children: [
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
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: ()  {
                    if(name_controller.text.isNotEmpty&&
                    price_controller.text.isNotEmpty&&
                    description_controller.text.isNotEmpty&&
                    imageurl!=null
                    ){
                      addProduct();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => productviewpage(),));
                    }else{
                      name_controller.text.isEmpty?showMessage(context, text: "Enter product Name", color: Colors.red):
                      price_controller.text.isEmpty?showMessage(context, text: "Enter product Price", color: Colors.red):
                      description_controller.text.isEmpty?showMessage(context, text: "Enter product Description", color: Colors.red):
                      description_controller.text.isEmpty?showMessage(context, text: "Enter product Description", color: Colors.red):
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
    );
  }
}
