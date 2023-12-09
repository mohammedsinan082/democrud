import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModelRiverpod{
  String gender;
  String id;
  bool delete;
  DocumentReference reference;

  CategoryModelRiverpod({
    required this.gender,
    required this.id,
    required this.delete,
    required this.reference,
  });


  CategoryModelRiverpod copyWith({
    String? gender,
    String? id,
    bool? delete,
    DocumentReference? reference,
    String? details,
  })=>
      CategoryModelRiverpod
        (gender: gender?? this.gender,
        id: id?? this.id,
        delete: delete?? this.delete,
        reference: reference?? this.reference,
      );
  factory CategoryModelRiverpod.fromJson(dynamic json)=>CategoryModelRiverpod(
    gender: json["gender"],
    id: json["id"],
    delete: json["delete"],
    reference: json["reference"],
  );
  Map<String,dynamic> toJson()=>{
    "gender":gender,
    "id":id,
    "delete":delete,
    "reference":reference,
  };}