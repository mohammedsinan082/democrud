import 'dart:io';

import 'package:democrud/features/test/home/screens/first_page.dart';
import 'package:democrud/model/riverpod_category_model.dart';
import 'package:democrud/model/riverpod_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../main.dart';
import '../../../../model/Constants.dart';
import '../controller/test_controller.dart';

// final changeProvider = StateProvider<>((ref) {
//
// });


class EditPage extends ConsumerStatefulWidget {
  final RiverpodModel riverpodModel;
  const EditPage({super.key,required this.riverpodModel});



  @override
  ConsumerState<EditPage> createState() => _EditPageState();
}

class _EditPageState extends ConsumerState<EditPage> {

  final formkey =GlobalKey<FormState>();

  var dropdownvalue;



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
  void initState() {
    name_controller = TextEditingController(text: widget.riverpodModel.name);
    age_controller = TextEditingController(text: widget.riverpodModel.age);
    imageurl=widget.riverpodModel.imageurl;
    dropdownvalue = widget.riverpodModel.category;
    print(dropdownvalue);
    super.initState();
  }






  @override
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
                                child: Text("Edit image",style: TextStyle(
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
                                List<String> drops = [];
                                for(CategoryModelRiverpod doc in categoryList){
                                  drops.add(doc.gender);
                                }
                                return  DropdownButton(
                                  underline: SizedBox(),
                                  isExpanded: true,
                                  hint: Text("select Category"),
                                  icon: Icon(Icons.keyboard_arrow_down_outlined),
                                  value: dropdownvalue,
                                  items: drops.map((e) =>
                                      DropdownMenuItem(
                                          value: e,
                                          child: Text(e,style: TextStyle(
                                              color: Colors.black,
                                              fontSize: w*0.04,
                                              fontWeight: FontWeight.w500,
                                          ),
                                          ))
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
                      ref.read(testControllerProvider.notifier).updateUser(age:age_controller =='' ? widget.riverpodModel.age: age_controller.text,image: imageurl== '' ? widget.riverpodModel.imageurl : imageurl,name:name_controller == ''? widget.riverpodModel.name: name_controller.text, riverpodModel: widget.riverpodModel,category:  dropdownvalue!);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>FirstPageRiverpod()));

                  },
                  child: Container(
                    height: w*0.13,
                    width: w*0.95,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(w*0.02),
                    ),
                    child: Center(child: Text("Update",style:
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
