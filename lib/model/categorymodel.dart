import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel{
  String name;
  String description;
  String id;
  bool delete;
  DocumentReference reference;
  DateTime date;

  CategoryModel({
    required this.name,
    required this.date,
    required this.id,
    required this.delete,
    required this.reference,
    required this.description,
  });


  CategoryModel copyWith({
    String? name,
    String? id,
    bool? delete,
    DocumentReference? reference,
    String? details,
    DateTime? date,
    String? description,
  })=>
      CategoryModel
        (name: name?? this.name,
        id: id?? this.id,
        date: date?? this.date,
        delete: delete?? this.delete,
        reference: reference?? this.reference,
        description: details?? this.description,
      );
  factory CategoryModel.fromJson(dynamic json)=>CategoryModel(
      name: json["name"],
      id: json["id"],
      delete: json["delete"],
      reference: json["reference"],
      description: json["details"],
      date: json["date"].toDate(),
  );
  Map<String,dynamic> toJson()=>{
    "name":name,
    "id":id,
    "delete":delete,
    "reference":reference,
    "details":description,
    "date":date
  };}