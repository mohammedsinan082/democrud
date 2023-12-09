import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:democrud/model/riverpod_category_model.dart';
import 'package:flutter/foundation.dart';

class RiverpodModel{
  String name;
  String age;
  String id;
  String imageurl;
  bool delete;
  DocumentReference reference;
  String category;

  RiverpodModel({
    required this.name,
    required this.age,
    required this.id,
    required this.imageurl,
    required this.delete,
    required this.reference,
    required this.category,
});

  RiverpodModel copyWith({
    String? name,
    String? age,
    String? id,
    String? imageurl,
    bool? delete,
    DocumentReference? reference,
    String? category,
}){
    return RiverpodModel(
        name: name ?? this.name,
        age: age ?? this.age,
        id: id ?? this.id,
        imageurl: imageurl ?? this.imageurl,
        delete: delete ?? this.delete,
        reference: reference ?? this.reference,
        category: category ?? this.category,
    );
  }

  factory RiverpodModel.fromJson(dynamic map){
    return RiverpodModel(
        name: map['name'],
        age: map['age'],
        id: map['id'],
        imageurl: map['imageurl'],
        delete: map['delete'],
        reference: map['reference'],
        category: map['category'],
    );
  }
  Map<String,dynamic> toJson() {
    return {
      'name':name,
      'age':age,
      'id':id,
      'imageurl':imageurl,
      'delete':delete,
      'reference':reference,
      'category':category,
    };
  }
}