import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:democrud/core/constants/firebase_constants.dart';
import 'package:democrud/model/categorymodel.dart';
import 'package:democrud/model/riverpod_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../model/Constants.dart';
import '../../../../model/riverpod_category_model.dart';

final testRepositoryProvider = Provider<TestRepository>((ref) {
  return TestRepository(firestore: FirebaseFirestore.instance);
});

class TestRepository{
  FirebaseFirestore _firestore;
  TestRepository({required FirebaseFirestore firestore}):_firestore=firestore;
  CollectionReference get _river => _firestore.collection(RiverpodConstants.usercollection);

  addUser({required String name,required String age,required String image,required CategoryModelRiverpod category}){
    DocumentReference ref = FirebaseFirestore.instance.collection(Constants.riverpoduser).doc();
    RiverpodModel a=RiverpodModel(
        name: name,
        age: age,
        id: '',
        imageurl: image,
        delete: false,
        category:category.gender,
        reference: ref);
    _river.add(a.toJson()).then((value){
      RiverpodModel model=a.copyWith(id: value.id,reference: value);
      value.update(model.toJson());
    });
  }

  Stream<List<RiverpodModel>> viewUser(){
    return _river.where('delete',isEqualTo: false)
        .snapshots().map((event) {
      List<RiverpodModel> userList =[];
      for(var doc in event.docs){
        userList.add(RiverpodModel.fromJson(doc.data()));
      }
      return userList;
    });
  }

  updateUser({required RiverpodModel riverpodModel,required String name,required String age,required String image,required String category}){
    RiverpodModel model= riverpodModel.copyWith(name: name,age: age,imageurl: image,category: category);
    riverpodModel.reference.update(model.toJson());
  }




  Stream<List<CategoryModelRiverpod>> getRiverpodCategory() {
    return FirebaseFirestore.instance.collection(RiverpodConstants.categorycollection)
        .where("delete",isEqualTo: false).snapshots().map((event) {
      List <CategoryModelRiverpod> category=[];
      for(var doc in event.docs){
        category.add(CategoryModelRiverpod.fromJson(doc.data()));
      }
      return category;
    });
  }


}